class User < ApplicationRecord
  belongs_to :role

  has_many :executions, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true
end
