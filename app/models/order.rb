class Order < ApplicationRecord
  belongs_to :customer, class_name: '::Customer', foreign_key: 'customer_id', optional: true
  belongs_to :douyin_customer, class_name: '::DouyinCustomer', foreign_key: 'douyin_customer_id', optional: true
  has_many :order_skus, class_name: 'Order::Sku', dependent: :destroy
  has_many :order_payments, class_name: 'Order::Payment', dependent: :destroy
  has_many :order_bundles, class_name: '::Order::Bundle', dependent: :destroy
  has_many :order_packages, class_name: '::Order::Package', dependent: :destroy
  has_many :order_logistics, class_name: '::Order::Logistic', dependent: :destroy
  has_many :order_coupons, class_name: '::Order::Coupon', dependent: :destroy

  has_one :gift_card, class_name: 'Order::GiftCard', dependent: :destroy

  enum status: { unpaid: 0, paid: 1, shipped: 2, completed: 3, reshipping: 4,
    reshipped: 5, qa_reject: 6, cancel: 8 }

  enum source: { wechat: 0, douyin: 1 }

  after_create :generate_uuid

  attr_accessor :skus, :total_price, :order_products, :get_delivery

  accepts_nested_attributes_for :order_skus, :order_bundles, :order_packages, :order_coupons, :gift_card, allow_destroy: true

  # Datasets
  class << self
    def filter_by_date(from=nil, to=nil)
      orders = Order.all
      if !from.nil?
        date_from = Order.arel_table[:created_at]
        orders = orders.where(date_from.gt(from))
      end
      if !to.nil?
        date_to = Order.arel_table[:created_at]
        orders = orders.where(date_to.lt(to))
      end
      orders
    end

    def order_by_day(from=nil, to=nil)
      orders = self.filter_by_date(from, to)
      self.default_timezone = :utc
      count = orders.group_by_day(:created_at).count
      self.default_timezone = :local
      count
    end

    def by_paid_unpaid_status(from=nil, to=nil)
      orders = self.filter_by_date(from, to)
      orders.where.not(status: [:paid, :unpaid])
      self.default_timezone = :utc
      count = orders.group_by_day(:created_at).count
      self.default_timezone = :local
      count
    end

    def by_status(from=nil, to=nil)
      orders = self.filter_by_date(from, to)
      orders.select(:status).group(:status).count
    end

    def get_to_cancel_orders
      # to = (Time.now.getlocal - 3600 * 24).strftime("%Y-%m-%d %H:%M:%S.%L")
      # orders = self.filter_by_date(nil, to)
      orders = Order.where("updated_at < (now() - interval '1' day)")
      orders = orders.where(status: :unpaid)
      orders

    end

  end

  def generate_uuid
    douyin_number = Rails.env.production? ? 940010000 : 940000001
    if Order.where(source: source).count == 0
      @order_number = source == 'wechat' ? 920000001 : douyin_number
    else
      # self.order_number = (Order.last.order_number || 920000001 + self.id) + 1
      # @order_number = Order.where(source: source).last.order_number + 1
      count = source == 'wechat' ? Order.where(source: 'douyin').count : Order.where(source: 'wechat').count
      @order_number = (source == 'wechat' ? 920000001 : douyin_number) + self.id - count + 1
    end

    update(order_number:@order_number)
  end

  def generate_wechat_payment
    payment = ::WechatTool::Mp.new()
    payment = payment.generate_wechat_payment('ShiSeido', self.order_number, self.total_price + (self.get_delivery || 0) , self.customer.open_id)
    order_payments.create({status: payment[:r1]["return_code"] === "FAIL" ? 2 : 0, error: payment[:r1]["return_msg"], data: payment[:r1][:raw]['xml']})
    { :payment_info => payment[:r2], order_id: self.id }
  end

  def generate_douyin_payment(ip)
    # for wechat h5 pay
    payment = ::WechatTool::H5.new()
    payment = payment.generate_wechat_payment('ShiSeido', self.order_number, self.total_price + (self.get_delivery || 0))
    wx_url = payment[:r1]['mweb_url']

    # for alipay
    payment = ::Alipay::Base.new()
    payment = payment.generate_payment(self.order_number, self.total_price + (self.get_delivery || 0))
    alipay_url = payment

    # return result
    {
      :payment_info => ::DouyinTool::Mp.new().generate_douyin_payment('ShiSeido', self.order_number, self.total_price + (self.get_delivery || 0), wx_url, alipay_url, self.created_at, ip),
      order_id: self.id
    }
  end

  def skus
    order_skus.map(&:sku)
  end

  def total_price
    # TODO: Quick dirty fix check later what is going on here
    # price = 0
    begin
      if need_trial
        price = 0
      else
        price = order_skus.sum { |item| (item.quantity || 1) * (item.price || 0) }
        price += order_packages.sum { |package| package.total_price }
      end
    rescue StandardError => e
      puts e.message
      puts e.backtrace.inspect
      price = 1
    end
    price
  end

  def package_total_price
    order_packages.sum { |package| package.package_total_price }
  end

  def payment_info
    order_payments.where(status: 1).first
  end

  def payment_method
    (payment_info && payment_info.payment_type) || '' if source === 'wechat'
    (order_payments.first && order_payments.first.payment_type)  || '' if source === 'douyin'
  end

  def get_delivery
    return 0 if total_price > 0
    return 20 if total_price == 0
    # delivery_fee = DeliveryFee.eager_load(country_provinces_delivery_fees: [country_province: :translations]).where('country_province_translations.name = ?', province).first
    # delivery_fee && delivery_fee.price
  end

  def order_address
    (province && city && area && (province != city ? province + city + area + address : city + area + address)) || address
  end

  def customer_name
    source === "wechat" ? (customer && customer.name) || '' : (douyin_customer && douyin_customer.name) || ''
  end

  def gather_address
    param = Hash.new()
    param['name'] = name.gsub(/[',','\n',' ']/,'')
    param['addr'] = address.gsub(/[',','\n',' ']/,'')
    param['mobile'] = mobile
    param
  end

  def validate_sku_quantity
    # validate order sku quantity whether is upper to product sku quantity limit
    order_skus.map { |sku| return false if sku.product_sku.available_quantity < 0 }
    # validate order package sku quantity whether is upper to product sku quantity limit
    order_packages.each { |package|
      package.product_package_skus.map { |sku|
        return false if sku.product_sku.available_quantity < 0
      }
    }
    # validate order bundle sku quantity whether is upper to product sku quantity limit
    order_bundles.map { |sku| return false if sku.product_sku.available_quantity < 0 }

    true
  end

  def update_sku_quantity
    # for order sku quantity
    order_skus.map { |sku|
      sku.product_sku.quantity -= sku.quantity
      sku.product_sku.save
    }
    # for order package sku quantity
    order_packages.each { |package|
      package.product_package_skus.map { |sku|
        sku.product_sku.quantity -= package.quantity * sku.quantity
        sku.product_sku.save
      }
    }
    # for order bundle sku quantity
    order_bundles.map { |sku|
      sku.product_sku.quantity -= sku.quantity
      sku.product_sku.save
    }
  end

  def validate_order_payments
    msg = nil

    # order package && sku validation
    order_packages.each { |package|
      # validate order packages is publish
      return "#{package.product_package.name}#{I18n.t('orders.no_publish')}" if package.product_package.publish == false
      # validate trial order sample package rule
      return "#{package.product_package.name}#{I18n.t('orders.sample_quantity_limit')}" if need_trial && package.product_package.product_category.is_sample && !::Product::Package.validate_sample(true, package.product_package_id, customer_id, source)
      # validate order product sku limit rule
      package.product_package_skus.each { |sku|
        return "#{sku.product_sku.name}#{I18n.t('orders.sku_quantity_limit')}" if sku.product_sku.limited_product && !sku.product_sku.validate_limit_rule(true, customer_id, source, package.quantity*sku.quantity)
      }
    }

    # order coupon validation
    if order_coupons.count > 0
      products = Array.new()
      order_packages.each { |package| package.product_package_skus.map { |sku| products.push(sku.product_sku.product_id) } }
      now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      order_coupons.each { |order_coupon|
        return "#{I18n.t('coupons.invalid_coupon')}" if !now.between?(order_coupon.coupon.expiry_start_date.to_s, order_coupon.coupon.expiry_end_date.to_s)
        return "#{I18n.t('coupons.used_coupon')}" if order_coupon.coupon.is_disposable && !order_coupon.coupon.validate_disposable(true)
        return "#{I18n.t('coupons.coupon_price_limit')}" if order_coupon.coupon.condition == "price" && total_price < order_coupon.coupon.price_condition
        return "#{I18n.t('coupons.coupon_product_limit')}" if order_coupon.coupon.condition == "product" && !products.include?(order_coupon.coupon.product_condition)
      }
    end

    msg
  end

  def gather_product_info
    params = Array.new()
    order_skus.map { |sku|
      param = Hash.new()
      param['bn'] = sku.product_sku.sku
      param['num'] = sku.quantity
      param['price'] = sku.price
      param['sale_price'] = sku.quantity * sku.price
      params.push(param)
    }
    params.concat(gather_bundle_sku_info)
    params.concat(gather_package_info)
    params.concat(gather_coupon_sku_info)
    params
  end

  def gather_bundle_sku_info
    params = Array.new()
    order_bundles.map { |item|
      param = Hash.new()
      param['bn'] = item.product_sku.sku
      param['num'] = item.quantity
      param['price'] = 0.0
      param['sale_price'] = 0.0
      params.push(param)
    }
    params
  end

  def gather_package_info
    params = Array.new()
    order_packages.each { |package|
      package.product_package_skus.map { |sku|
        param = Hash.new()
        param['bn'] = sku.product_sku.sku
        param['num'] = package.quantity * sku.quantity
        param['price'] = sku.price
        param['sale_price'] = package.quantity * sku.quantity * sku.price
        params.push(param)
      }
    }
    params
  end

  def gather_coupon_sku_info
    params = Array.new()
    order_coupons.map { |item|
      param = Hash.new()
      param['bn'] = item.product_sku.sku
      param['num'] = item.quantity
      param['price'] = 0.0
      param['sale_price'] = 0.0
      param['coupon_code'] = item.coupon.code
      params.push(param)
    }
    params
  end

  def gather_invoice
    params = Hash.new()
    params['tax_title'] = invoice_title
    params['taxpayer_identity_number'] = tax_number
    params['tax_email'] = email
    params['tax_mobile'] = mobile
    params
  end

  def update_skus(logi_params)
  # def update_skus(order_sku_params)
    # order_sku_params.each do |sku|
      # order_sku = Order::Sku.eager_load(:product_sku).where('sku = ? AND order_id = ?', sku['bn'], self.id).first
      # order_sku = Order::Sku.eager_load(:product_sku).where('order_id = ?', self.id).first
      # if order_sku.nil?
      #   order_sku = Order::Bundle.eager_load(:product_sku).where('sku = ? AND order_id = ?', sku['bn'], self.id).first!
      # end
      # if !order_sku.nil?
        # order_sku.quantity = sku["num"]
    #     order_sku.shipping_company = sku["logi_name"]
    #     order_sku.shipping_number = sku["logi_no"]
    #     order_sku.save
    #   end
    # end
    logi_params.split(';').each do |logi|
      order_logi = Order::Logistic.where('order_id = ? AND shipping_number = ? ', self.id, logi).first
      if order_logi.nil?
        Order::Logistic.create({order_id: self.id, shipping_number: logi})
      end
    end
  end

  def order_paid(result, type)
    self.update({status: 1})
    order_payments.last.update({status: 1, transaction_id: result['transaction_id']}) if source === 'wechat'
    # for douyin payments
    if source === 'douyin' && order_payments.where(status: 1).count === 0
      transaction_id = type == 'wechat' ? result['transaction_id'] : result['trade_no']
      payment_type = type == 'wechat' ? 1 : 2
      order_payments.create({status: 1, transaction_id: transaction_id, error: nil, data: result, payment_type: payment_type})
    end
    OrderWorker.perform_in(3.seconds, id)
    send_notification
  end

  def order_failed(result, type)
    self.order.update({status: 0})
    order_payments.last.update({status: 2}) if source === 'wechat'
    # for douyin payments
    if source === 'douyin' && order_payments.where(status: 2).count === 0
      payment_type = type == 'wechat' ? 1 : 2
      order_payments.create({status: 2, error: result, data: result, payment_type: payment_type})
    end
  end

  def send_notification
    OrderStatusUpdateWorker::OrderPaid.perform_async(id) if status == 'paid'
    OrderStatusUpdateWorker::OrderShipped.perform_async(id) if status == 'shipped'
    OrderStatusUpdateWorker::OrderReturnReceived.perform_async(id) if status == 'reshipping'
    OrderStatusUpdateWorker::OrderReturnRejected.perform_async(id) if status == 'qa_reject'
    OrderStatusUpdateWorker::OrderRefunded.perform_async(id) if status == 'reshipped'
  end
end
