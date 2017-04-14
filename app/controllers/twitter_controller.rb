class TwitterController < ApplicationController
  def callback
    raise request.env["omniauth.auth"].inspect
  end
end
