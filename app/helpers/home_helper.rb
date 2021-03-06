module HomeHelper
	def draw_calendar
		total_score = 0
		out = "<span style='display:none' id='selectedDate' data-date_long='' data-linked_cell=''></span>"
		out += "<table class=\"calendar homepage pull-left\" style=\"margin-bottom: 0px;\"><tr>"
		now = DateTime.now
		(-12..0).each do |i|
			current_day = now + i.days
			out+="<td style=\"width: 40px; padding: 8px 3px 8px 3px;\" data-date_short='#{current_day.strftime("%d/%m")}' data-linked_cell='#{current_day.strftime("%d-%m")}' data-date_long='#{current_day.strftime("%Y/%m/%d")}'>#{current_day.strftime("%d/%m")}</td>"
		end
		out+="<tr>"
		(-12..0).each do |i|
			current_day = now + i.days
			wus = current_user.workout_units.joins(:workout_unit_type).where("DATE_FORMAT(date,'%Y-%m-%d')='#{current_day.strftime('%Y-%m-%d')}'")
			out+="<td id='day-score-#{current_day.strftime("%d-%m")}' style=\"width: 40px; padding: 8px 3px 8px 3px;\">"
			#out+="<div><a class='testElement'>test</a></div>"
			wus.each do |wu|
				#out+=wu.workout_unit_type.inspect
				total_score += wu.workout_unit_type.difficulty
				out+="<div data-id='#{wu.id}' data-toggle='tooltip' title='+#{wu.workout_unit_type.difficulty} - #{wu.workout_unit_type.category}/#{wu.workout_unit_type.name}' class='workout-unit-item' style='width: 40px; background-color: #{wu.workout_unit_type.color}'>+#{wu.workout_unit_type.difficulty}</div>"
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
