# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    # before_action :authenticate_user!
    before_action :authenticate_admin

    def authenticate_admin
      not_found unless current_user && access_whitelist
    end

    private
      def access_whitelist
        user_signed_in? && (current_user.has_role?(:admin) || current_user.has_role?(:editor))
      end

      def not_found
        begin
          raise ActionController::RoutingError.new('404 - The page you are looking for cannot be found.')
        rescue
          render_404
        end
      end

      def render_404
        render file: "#{Rails.root}/public/404", status: :not_found
      end
  end
end
