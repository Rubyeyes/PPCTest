class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable   

  belongs_to :role_option
  belongs_to :status_option
  has_many :projects
  has_many :sent_notifications, class_name: 'Notification', foreign_key: "sender_id"
  has_many :received_notifications, class_name: 'Notification', foreign_key: "recipient_id"

  # User::Roles
  # The available roles
  # Roles = [ :admin , :default ]

  # def is?( requested_role )
  #   self.role == requested_role.to_s
  # end  

  def self.notification_recipients object, current_user, controller_name
    if current_user.role == "factory"
      where.not(role: "factory")
    elsif current_user.role == "admin"
      if controller_name == "projects"
        where("role LIKE ?  or fullname LIKE ?", "user", "%#{object.user.fullname}%")
      elsif controller_name == "po_products"  
        where("role LIKE ?  or fullname LIKE ?", "user", "%#{object.product.project.user.fullname}%")
      else  
        where("role LIKE ?  or fullname LIKE ?", "user", "%#{object.project.user.fullname}%")
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation, :role, :fullname)
  end

end
