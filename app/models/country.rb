class Country < ApplicationRecord
  belongs_to :region
  has_many :airports
end
