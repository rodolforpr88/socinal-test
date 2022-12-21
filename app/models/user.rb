class User < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :executions, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true

  accepts_nested_attributes_for :roles, allow_destroy: true
end
