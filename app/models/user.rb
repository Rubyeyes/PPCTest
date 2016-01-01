class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable   

  # User::Roles
  # The available roles
  Roles = [ :admin , :default ]

  def is?( requested_role )
    self.role == requested_role.to_s
  end  

  private

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation, :role)
  end

end
