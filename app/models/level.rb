class Level < ApplicationRecord
  scope :achieved_with, ->(xp) { where(xp_needed: ..xp).order(:level_no).last }
  serialize :rewards

  validate :valid_reward_types?

  private

  def valid_reward_types?
    types = %i[ redeemable_tokens redeemable_b_tokens redeemable_snekot
                max_receivers max_ttl max_messages ]
    rewards.each_key do |type|
      break false unless types.include? type
    end
  end
end
