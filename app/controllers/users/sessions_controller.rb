class Users::SessionsController < Devise::SessionsController
  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(_resource_or_scope)
    # this codes seems to do nothing
    # users.update(signInCount: (signInCount+1))

    # if current_user.signInCount == 1
    #  stored_location_for(resource_or_scope) || edit_user_session_path
    # elsif current_user.admin == true
    #  stored_location_for(resource_or_scope) || admin_root_path
    # else
    #  stored_location_for(resource_or_scope) || root_path
    # end
  end

  def update
    path = if current_user.admin
             admin_root_path
           else
             root_path
           end

    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to(path, notice: 'User was successfully updated.') }
        format.json { render(:show, status: :ok, location: current_user) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: current_user.errors, status: :unprocessable_entity) }
        render('edit')
        puts('Dummy')
      end
    end
  end

  private

  def user_params
    params.permit(:id, :major, :bio, :birthdate)
  end
end
