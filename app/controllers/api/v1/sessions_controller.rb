# rubocop:disable all

module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user_password = params[:session][:password]
        user_email = params[:session][:email]

        user = user_email.present? && User.find_by(email: user_email)
        if user && user.valid_password?(user_password)
          sign_in user, store: false
          user.generate_token
          user.save!
          render json: { token: user.token, email: user.email }, status: 200
        else
          render json: { error: "Invalid email or password" }, status: 422
        end
      end

      def destroy
        user = User.find_by(token: params[:id])
        user.generate_token
        user.save
        return head 204
      end
    end
  end
end
