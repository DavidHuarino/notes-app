class Note < ApplicationRecord
    validates_presence_of :name, :description
end
