class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users             # group.users によってデータを呼び出すことができるようになる
  validates :name, presence: true, uniqueness: true  # null制約 & 一意性制約
  # has_many :messages
end
