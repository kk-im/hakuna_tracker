class Project < ApplicationRecord
  belongs_to :user
  has_many :sessions

  validates :name, presence: true, uniqueness: true
  validates :client, presence: true
end
