class Connection < ApplicationRecord
  belongs_to :castable, polymorphic: true
  belongs_to :receivable, polymorphic: true
end
