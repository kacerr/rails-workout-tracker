module UsersHelper
	def getNameOrEmail(user)
		if user.display_name && user.display_name!=''
			return user.display_name
		else
			return user.email
		end
	end
end
