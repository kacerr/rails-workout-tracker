# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	highlightCell = (e) ->
		e.preventDefault()
		$(this).text('+')
		$(this).css('cursor','pointer')

	unhighlightCell = (e) ->
		e.preventDefault()
		$(this).text($(this).data('date_short'))

	addWorkoutUnit = (e) ->
		e.preventDefault
		$('#selectedDate').data('date_long', $(this).data('date_long'))
		$('#selectedDate').data('linked_cell', $(this).data('linked_cell'))
		$('#selectWorkoutUnit').modal()

	removeWorkoutUnit = (e) ->
		e.preventDefault
		if e.shiftKey
			elementToRemove = $(this)
			$.ajax '/workout_units/' + $(this).data('id') + '.json',
				type: 'DELETE'
				dataType: 'json'
				error: (jqXHR, textStatus, errorThrown) ->
					$('body').append "AJAX Error: #{textStatus}"
				success: (data, textStatus, jqXHR) ->
					console.log $(this)
					elementToRemove.remove()

	window.wt.selectWorkoutUnit = (workoutUnitType) ->
		#alert ($('#selectedDate').data('date_long') + '  ' + workoutUnitType)
		# do ajax request to save selected workoutUnit
		payload = {
			'workout_unit[date]': $('#selectedDate').data('date_long'),
			'workout_unit[workout_unit_type_id]': workoutUnitType
		}

		$.ajax '/workout_units.json',
			type: 'POST'
			data: payload,
			dataType: 'json'
			error: (jqXHR, textStatus, errorThrown) ->
				$('body').append "AJAX Error: #{textStatus}"
			success: (data, textStatus, jqXHR) ->
				console.log(data)
				console.log $('#selectedDate').data('linked_cell')
				console.log $('#day-score-' + $('#selectedDate').data('linked_cell')).html()
				console.log '<div style=\'background-color: ' + data.workout_unit_type.color + '\'>+' + data.workout_unit_type.difficulty + '</div>'
				$('#day-score-' + $('#selectedDate').data('linked_cell')).append('<div style=\'background-color: ' + data.workout_unit_type.color + '\'>+' + data.workout_unit_type.difficulty + '</div>')
				#console.log($('#day-score-' + $('#selectedDate').data('linked_cell')))
				#$('body').append "Successful AJAX call: #{data}"

		$('#selectWorkoutUnit').modal('hide')

	$('[data-toggle="tooltip"]').tooltip({'placement': 'top'});
	$('.calendar.homepage tr:first td').on 'mouseover', window.event, highlightCell
	$('.calendar.homepage tr:first td').on 'mouseout', window.event, unhighlightCell
	$('.calendar.homepage tr:first td').on 'click', window.event, addWorkoutUnit

	$('.workout-unit-item').on 'click', window.event, removeWorkoutUnit

$(document).ready ready
$(document).on "page:load", ready