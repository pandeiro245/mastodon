class TwitterController < ApplicationController
  def callback
    data = request.env["omniauth.auth"]
    @user = User.find_or_create_by(
      email: "#{data['uid']}@#{request.domain}",
    )
    unless @user.account.present?
      @user.account = Account.new(username: data[:info][:nickname])
      @user.password  = Devise.friendly_token[0,20]
      @user.skip_confirmation!
    end
    @user.account.avatar_remote_url = data[:info][:image]
    @user.save!
    sign_in @user
    redirect_to :root
  end
end
