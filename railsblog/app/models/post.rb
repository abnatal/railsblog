class Post < ApplicationRecord
    belongs_to :user
    validates_presence_of :title, :content
    has_rich_text :content
    has_many :comments, dependent: :destroy
end
