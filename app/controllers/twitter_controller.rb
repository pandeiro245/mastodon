class TwitterController < ApplicationController
  def callback
    data = request.env["omniauth.auth"]
    sign_in UserTwitter.sign_in(data)
    redirect_to :root
  end
end
