class Note < ApplicationRecord
    validates_presence_of :name, :description
    belongs_to :user
    def self.getNotesByCurrentUser(user)
        where(user_id: user)
    end
end
