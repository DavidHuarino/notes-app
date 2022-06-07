class Note < ApplicationRecord
    validates_presence_of :name, :description
    #validates :name, length: {maximum: 150}
    validates :description, length: {maximum: 600}
    belongs_to :user
    # def self.getNotesByCurrentUser(user)
    #     where(user_id: user)
    # end
    def self.search(params, current_user_id)
        #params[:query].blank? ? all : where("name LIKE ?", "%#{sanitize_sql_like(params[:query])}%")
        notesByUser = Note.where(user_id: current_user_id)
        params[:query].blank? ? notesByUser : notesByUser.where("name LIKE ?", "%#{sanitize_sql_like(params[:query])}%")
    end
end
