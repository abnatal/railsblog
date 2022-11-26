class Post < ApplicationRecord
    validates_presence_of :title, :content
    has_rich_text :content
end
