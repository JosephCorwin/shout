class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :stash
  has_many :messages
  has_many :casters, as: :castable, class_name: 'Connection'
  has_many :receivers, as: :receivable, class_name: 'Connection'

  def find_caster_ids
    receivers.where.not(approved_at: nil).pluck(:castable_id)
  end

  def approve_receiver(connection)
    connection.
  end
end
