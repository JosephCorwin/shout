class DestroyDeadMessages < ApplicationJob
  def perform
    (1..Message.maximum(:ttl)).to_a.each do |ttl|
      cutoff = ttl.days.ago
      Message.where(ttl: ttl, created_at: ..cutoff).delete_all
    end
  end
end