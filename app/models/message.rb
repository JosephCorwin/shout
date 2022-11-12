class Message < ApplicationRecord
  belongs_to :user

  scope :connected, ->(user) { where(user_id: user.find_caster_ids << user.id) }

  serialize :b_chain

  def organic_boost(boost_user, token_count)
    return unless validate_organic_boost(boost_user, token_count)
    return unless user.messages.create!(body: body, ttl: token_count, boost_chain: boost_chain << boost_user.id, boost_type: :organic)

    self.ttl += token_count
    save
    user.stash.destroy_tokens(token_count)
  end

  private

  def grant_xp
    xp_reward = b_chain.size * 5
    b_chain.each do |uid|
      User.find_by(id: uid).stash.add_xp(xp_reward)
    end
  end

  def validate_organic_boost(boost_user, token_count)
    return unless validate_user_connection(boost_user)
    return if b_chain.include? boost_user.id
    return unless user.stash.tokens >= token_count
    return if user.stash.max_ttl < token_count

    true
  end

  def validate_user_connection(boost_user)
    user.casters.pluck(:receivable_id).include?(boost_user.id)
  end
end
