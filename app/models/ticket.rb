class Ticket < ApplicationRecord
    belongs_to :users, optional: true
end
