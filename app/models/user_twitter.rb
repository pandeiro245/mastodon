class UserTwitter
  def self.sign_in(data)
    user = User.find_or_create_by(
      id: data['uid']
    )
    unless user.account.present?
      user.email = "#{data['uid']}@#{request.domain}"
      user.account = Account.new(username: data[:info][:nickname])
      user.password  = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end
    user.account.avatar_remote_url = data[:info][:image]
    user.save!
    user
  end

  def self.pull_all
    User.all.each do |user|
      user.email = "#{user.email.split('@').first}@example.com"
      user.save!
    end
  end
end

