class Project < ApplicationRecord
  belongs_to :user
  has_many :timelapses

  validates :name, presence: true, uniqueness: true
  validates :client, presence: true
end
