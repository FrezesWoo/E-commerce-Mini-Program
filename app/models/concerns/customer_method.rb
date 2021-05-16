module CustomerMethod
  extend ActiveSupport::Concern

  def gather_account_info
    params = Hash.new()
    params['name'] = name
    params['mobile'] = phone
    params['crm_member_no'] = crm_member_no if crm_member_no
    params
  end

  def validate_crm_removed(source)
    params = Hash.new()
    params["member_no"] = crm_member_no
    query = ::CrmShiseido::Query.new()
    member = query.ec_api('EC_MemberInfoQuery', params, source)
    member = Hash.from_xml(member)["Result"]
    if member && member["MemberInfo"] && member["MemberInfo"]["Status"] == '99'
      self.update({crm_member_no: nil})
      return true
    end
    return false
  end

  def create_crm_number(source)
    return if crm_member_no
    check_member(source)
    return if crm_member_no
    params = Hash.new()
    query = ::CrmShiseido::Query.new()
    params["name"] = name
    params["mobile"] = phone
    params["sex"] = gender.to_s
    params["birth_day"] = (birthday || Time.now).strftime("%Y%m%d")
    params["wechat_open_id"] = open_id if source == 'wechat'
    params["is_get_info_by_email"] = "0"
    params["is_get_info_by_s_m_s"] = agreed_marketing ? "1" : "0"
    self.crm_member_no = query.create_new_customer(params, source)
    self.save
    CustomerCreateWorker.perform_async(phone) if !name.nil?
  end

  def update_member(data)
    return if crm_member_no.nil?
    params = Hash.new()
    params["mobile"] = phone
    params["wechat_open_id"] = open_id
    params["wechat_union_id"] = data[:union_id]
    query = ::CrmShiseido::Query.new()
    req = query.ec_api('EC_MemberBind', params, "wechat")
    puts Hash.from_xml(req)["Result"]
  end

  def get_membership_info(source)
    params = Hash.new()
    params["member_no"] = crm_member_no
    query = ::CrmShiseido::Query.new()
    member = query.ec_api('EC_MemberInfoQuery', params, source)
    member = Hash.from_xml(member)["Result"]
    query = ::CrmShiseido::Query.new()
    points = query.ec_api('EC_MemberPointQuery', params, source)
    points = Hash.from_xml(points)["Result"]
    self.name = member && member["MemberInfo"] && member["MemberInfo"]["MemberName"] if name.nil?
    self.gender = member && member["MemberInfo"] && member["MemberInfo"]["Gender"] if gender.nil?
    self.save
    {
        member_info: member && member["MemberInfo"],
        member_point: points && points["CurrentPointInfo"]
    }
  end

  private

  def check_member(source)
    query = ::CrmShiseido::Query.new()
    params = Hash.new()
    params["user_id"] = phone
    params["user_id_type"] = '0'
    req = query.ec_api('EC_MemberVerify', params, source)
    if Hash.from_xml(req) && Hash.from_xml(req)["Result"]["MemberNo"]
      self.crm_member_no = Hash.from_xml(req)["Result"]["MemberNo"]
      self.save
    end
  end
end