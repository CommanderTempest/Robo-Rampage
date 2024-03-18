extends Node3D

@onready var cooldown_timer = $CooldownTimer
@onready var weapon_position: Vector3 = weapon_mesh.position
@onready var ray_cast_3d = $RayCast3D

@export var fire_rate := 14.0
@export var recoil := 0.05 
@export var weapon_mesh: Node3D
@export var weapon_damage := 15
@export var muzzle_flash: GPUParticles3D
@export var sparks: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("fire"):
		if cooldown_timer.is_stopped():
			shoot()
	
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * 10.0)

func shoot() -> void:
	muzzle_flash.restart()
	cooldown_timer.start(1.0 / fire_rate)
	var collider = ray_cast_3d.get_collider()
	printt("Weapon fired!", collider)
	weapon_mesh.position.z += recoil
	
	if collider is Enemy:
		collider.hitpoints -= weapon_damage
	var spark = sparks.instantiate()
	add_child(spark)
	spark.global_position = ray_cast_3d.get_collision_point()