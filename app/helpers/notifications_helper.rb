module NotificationsHelper
	def notification_weight notification
		notification.read == false ? "font-weight:bold" : "font-weight:normal"		
	end
end
