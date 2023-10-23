# frozen_string_literal: true

# To deliver this notification:
#
# WineNotification.with(post: @post).deliver_later(current_user)
# WineNotification.with(post: @post).deliver(current_user)

# Wine Notification
class WineNotification < Noticed::Base
  deliver_by :actioncable

  def message
    t('.message')
  end

  def url
    wine_path(params[:id])
  end
end
