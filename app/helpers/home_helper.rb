module HomeHelper
	def draw_calendar
		total_score = 0
		out = "<span style='display:none' id='selectedDate' data-date_long=''></span>"
		out += "<table class=\"calendar pull-left\" style=\"margin-bottom: 0px;\"><tr>"
		now = DateTime.now
		(-6..6).each do |i|
			current_day = now + i.days
			out+="<td style=\"width: 40px; padding: 8px 3px 8px 3px;\" data-date_short='#{current_day.strftime("%d/%m")}' data-date_long='#{current_day.strftime("%Y/%m/%d")}'>#{current_day.strftime("%d/%m")}</td>"
		end
		out+="<tr>"
		(-6..6).each do |i|
			current_day = now + i.days
			wus = WorkoutUnit.all.joins(:workout_unit_type).where("DATE_FORMAT(date,'%Y-%m-%d')='#{current_day.strftime('%Y-%m-%d')}'")
			out+="<td style=\"width: 40px; padding: 8px 3px 8px 3px;\">"
			wus.each do |wu|
				#out+=wu.workout_unit_type.inspect
				total_score += wu.workout_unit_type.difficulty
				out+="<div style='width: 40px; background-color: #{wu.workout_unit_type.color}'>+#{wu.workout_unit_type.difficulty}</div>"
			end
			out+="</td>"
		end
		out+="</tr>"
		out+="</table>"
		out+="<div style='float:left'>Your total <br> score is: <br><br><span style='background-color:orange; font-size: 40px;'> #{total_score} </span></div>"
	end

	def workout_unit_selector(js_callback_function_name)
		out="<div class='modal' id='selectWorkoutUnit'>"
		out+="<div class='modal-dialog'>"
		WorkoutUnitType.all.each do |wut|
			out += "<button onclick='#{js_callback_function_name}(#{wut.id})' style='width: 200px; border: 0px; margin: 1px; background-color: #{wut.color}'>#{wut.name}</button><br>"
		end
		out +="</div>"
		out +="</div>"
	end
end
