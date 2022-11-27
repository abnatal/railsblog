module ApplicationHelper
    def can_modify?(object)
        current_user == object.user 
    end
end
