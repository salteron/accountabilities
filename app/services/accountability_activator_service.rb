class AccountabilityActivatorService
  def initialize(accountability)
    @accountability = accountability
  end

  def activate
    return if @accountability.activated_at.present?
    @accountability.update_attributes(activated_at: Time.zone.now)
  end
end
