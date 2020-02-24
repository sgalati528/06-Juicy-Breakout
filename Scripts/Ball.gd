extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")
onready var camera = get_node("/root/Game/Camera") 

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	# Check for collisions
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Tiles"):
			Game.change_score(body.points)
			$Explodingsound.playing = true
			body.queue_free()
			camera.add_trauma(0.3)
		if body.name == "Paddle":
			$PaddleHit.playing = true 
		if body.name == "Wall":
			camera.add_trauma(0.2)
	
	if position.y > get_viewport().size.y:
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()
