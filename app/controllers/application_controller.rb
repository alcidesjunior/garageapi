
    class ApplicationController < ActionController::API
      include Knock::Authenticable

      def authorize_as_admin
        return unauthorized_entity unless !current_user.nil? && current_user.is_admin?
      end


    end
