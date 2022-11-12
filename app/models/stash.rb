class Stash < ApplicationRecord
  belongs_to :user

  serialize :purse

  def grant_redeemable
    redeemables = {}
    find_level_rewards.each_pair do |type, value|
      next unless type.match(/redeemable_/)

      redeemables[type] = purse[type] + value
    end
    update!(purse: redeemables)
  end

  def find_level_rewards
    Level.achieved_with(xp).pluck(:rewards)[0]
  end
end
