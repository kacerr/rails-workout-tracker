module WorkoutUnitsHelper
	def draw_summary_calendar
		total_score = 0
		out = "<span style='display:none' id='selectedDate' data-date_long='' data-linked_cell=''></span>"
		out += "<table class=\"calendar pull-left\" style=\"margin-bottom: 0px;\"><tr>"
		now = DateTime.now
		out += "<td style='width: 250px;'></td>"
		(-20..0).each do |i|
			current_day = now + i.days
			out+="<td style=\"width: 40px; padding: 8px 3px 8px 3px;\" >#{current_day.strftime("%d/%m")}</td>"
		end
		out+="<td>total</td>"

		@users_hash.keys.each do |user_id|
			out+="<tr>"
			out += "<td style='width: 150px;'>#{@users_hash[user_id]["display_name"]}</td>"
			(-20..0).each do |i|
				current_day = now + i.days
				wus = @wus_hash[user_id][current_day.strftime('%Y-%m-%d')]
				out+="<td id='day-score-#{current_day.strftime("%d-%m")}' style=\"width: 40px; padding: 8px 3px 8px 3px;\">"
				#out+=wus.inspect
				#out+="<div><a class='testElement'>test</a></div>"
				if wus
					wus.each do |wu|
						#out+=wu.workout_unit_type.inspect
						total_score += wu.workout_unit_type.difficulty
						out+="<div data-id='#{wu.id}' data-toggle='tooltip' title='+#{wu.workout_unit_type.difficulty} - #{wu.workout_unit_type.category}/#{wu.workout_unit_type.name}' class='workout-unit-item' style='width: 40px; background-color: #{wu.workout_unit_type.color}'>+#{wu.workout_unit_type.difficulty}</div>"
					end
				end
				out+="</td>"
			end
			out+="<td style='align:center;'>"
			out+="<span style='background-color:orange; font-size: 30px;'> #{@users_hash[user_id]["total"]} </span>"
			out+="</td>"
			out+="</tr>"
		end
		out+="</table>"
		out
	end
end
