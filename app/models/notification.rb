class Notification < ApplicationRecord
  has_many :assignments
  has_many :users, through: :assignments
end
