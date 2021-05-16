module TokenMethod
  extend ActiveSupport::Concern

  private

  def random_token
    self.token = [*('a'..'z'),*('0'..'9'),*('A'..'Z')].shuffle[0,80].join
  end

  def set_expire_at
    self.expire_at = Time.now + 4.days
  end
end