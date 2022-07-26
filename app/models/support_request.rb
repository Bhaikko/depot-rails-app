# Will store received emails on Support route
class SupportRequest < ApplicationRecord
  belongs_to :order, optional: true
end
