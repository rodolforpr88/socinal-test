class Role < ApplicationRecord
  validates :name, uniqueness: true, presence: true
end
