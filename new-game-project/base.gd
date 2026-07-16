extends StaticBody2D

signal base_destroyed
signal health_changed(current, max_val)

@export var max_health := 100
var health: int

func _ready() -> void:
	health = max_health

func take_damage(amount: int) -> void:
	health -= amount
	health_changed.emit(health, max_health)
	if health <= 0:
		base_destroyed.emit()
		print("Base destroyed - game over")
