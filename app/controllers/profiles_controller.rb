class ProfilesController < ApplicationController

  def update
    profile = Profile.find params[:id]
    respond_to do |format|
      if profile.update(profile_params)
        @notice = {message: "Profile updated successfully", type: "success"}
        format.html { redirect_to accounts_amazon_path}
      else
        error_messages = profile.errors.full_messages.join(", ")
        @notice = {message: "Error updating profile - #{error_messages}", type: "error"}
        format.html { redirect_to accounts_amazon_path}
      end
    end
  end

  def profile_params
    params.require(:profile).permit(:is_actively_managed)
  end
end
