class NotificationsController < ApplicationController

  before_action :authenticate_user!

  load_and_authorize_resource except: [:destroy]

  def index
    @notifications = current_user.notifications
    respond_to do |format|
      format.html
      # format.json { render json: @feeds }
    end
    @notifications.each do |n|
      n.update_attributes(read: true)
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notification_url,notice: 'Notification was successfully deleted.' }
      format.js
    end
  end

end
