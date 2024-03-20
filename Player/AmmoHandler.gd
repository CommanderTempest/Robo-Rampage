extends Node
class_name AmmoHandler

@export var ammo_label: Label

enum ammo_type {
	BULLET,
	SMALL_BULLET
}

var ammo_storage := {
	ammo_type.BULLET: 10,
	ammo_type.SMALL_BULLET: 60
}

#set the text label for ammunition to the correct value on load
func _ready():
	update_ammo_label(ammo_type.BULLET)

func has_ammo(type: ammo_type) -> bool:
	if ammo_storage[type] > 0:
		return true
	else: 
		return false
func use_ammo(type: ammo_type) -> void:
	if (has_ammo(type)):
		ammo_storage[type] -= 1
		update_ammo_label(type)

func update_ammo_label(type: ammo_type) -> void:
	ammo_label.text = str(ammo_storage[type])

func add_ammo(type: ammo_type, amount: int) -> void:
	ammo_storage[type] += amount
	update_ammo_label(type)
