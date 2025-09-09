class Region < ApplicationRecord
  belongs_to :continent
  has_many :countries
end
