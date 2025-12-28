class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :board
end
