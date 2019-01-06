module UsersHelper
    def user_new_or_edit
        if action_name == 'new'
          users_path
        elsif action_name == 'edit'
          edit_user_path
        end
    end
end
