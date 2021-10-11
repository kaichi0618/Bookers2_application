class Group < ApplicationRecord
  has_many :grouo_users
  has_many :users, through: :group_users
  validates :name, presence: true, uniquness: true
end
