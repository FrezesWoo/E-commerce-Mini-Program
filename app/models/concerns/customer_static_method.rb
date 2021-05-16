module CustomerStaticMethod
  extend ActiveSupport::Concern

  def by_phone(phone)
    where(phone: phone)
  end

  def by_phone_and_id(phone, id)
    where('phone = ? AND id <> ?', phone, id)
  end

  def to_csv
    attributes = %w[id gender name open_id union_id email phone birthday crm_member_no created_at updated_at]
    "\uFEFF" + CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |customer|
        csv << attributes.map { |attr|
          customer.send(attr)
        }
      end
    end
  end
end
