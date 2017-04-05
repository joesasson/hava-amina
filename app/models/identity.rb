class Identity < ApplicationRecord
  belongs_to :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable,
         :omniauth_providers => [:twitter, :github, :linkedin, :google]

  def self.from_omniauth(auth_hash)
    user = User.find_or_create_by(email: auth_hash['info']['email'])
    Identity.find_or_create_by(provider: auth_hash['provider'],
                               uid: auth_hash['uid'],
                               user_id: user.id)
  end
end
