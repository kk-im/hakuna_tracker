class Project < ApplicationRecord
  belongs_to :user
  has_many :timelapses, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :client, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_or_client,
    against: [ :name, :client ],
    using: {
      tsearch: { prefix: true }
    }

end
