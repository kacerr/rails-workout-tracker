# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
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
	$('#selectWorkoutUnit').modal()

window.selectWorkoutUnit = (workoutUnitType) ->
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
			$('body').append "Successful AJAX call: #{data}"

	$('#selectWorkoutUnit').modal('hide')

ready = ->
	$('.calendar tr:first td').on 'mouseover', event, highlightCell
	$('.calendar tr:first td').on 'mouseout', event, unhighlightCell
	$('.calendar tr:first td').on 'click', event, addWorkoutUnit

$(document).ready ready
$(document).on "page:load", ready