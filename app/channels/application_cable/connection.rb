module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_entity

    def connect
      self.current_entity = find_verified_entity
    end

    private

    def find_verified_entity
      if user_signed_in?
        current_user
      elsif expert_signed_in?
        current_expert
      else
        reject_unauthorized_connection
      end
    end

    def user_signed_in?
      cookies.encrypted[:user_id].present? && (User.find_by(id: cookies.encrypted[:user_id]))
    end

    def expert_signed_in?
      cookies.encrypted[:expert_id].present? && (Expert.find_by(id: cookies.encrypted[:expert_id]))
    end

    def current_user
      User.find_by(id: cookies.encrypted[:user_id])
    end

    def current_expert
      Expert.find_by(id: cookies.encrypted[:expert_id])
    end
  end
end
