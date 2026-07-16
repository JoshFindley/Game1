extends Node2D

signal day_started(day_number)
signal night_started(day_number)

const DAY_LENGTH := 60.0
const NIGHT_LENGTH := 30.0
const DAY_COLOR := Color(1, 1, 1)
const NIGHT_COLOR := Color(0.22, 0.25, 0.42)
const TRANSITION_TIME := 2.0

var time_remaining := DAY_LENGTH
var is_day := true
var wave_number := 0
var day_number := 1

@onready var label := $CanvasLayer/Label
@onready var canvas_modulate := $CanvasModulate

func _process(delta: float) -> void:
	time_remaining -= delta
	label.text = "Day " + str(day_number) + "  |  " + str(ceili(time_remaining)) + "s"
	if time_remaining <= 0:
		if is_day:
			start_night()
		else:
			start_day()

func start_night() -> void:
	is_day = false
	time_remaining = NIGHT_LENGTH
	wave_number += 1
	_tween_light(NIGHT_COLOR)
	night_started.emit(day_number)

func start_day() -> void:
	is_day = true
	time_remaining = DAY_LENGTH
	day_number += 1
	_tween_light(DAY_COLOR)
	day_started.emit(day_number)

func _tween_light(target: Color) -> void:
	var t := create_tween()
	t.tween_property(canvas_modulate, "color", target, TRANSITION_TIME)
