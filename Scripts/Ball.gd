extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")


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
		if body.is_in_group("Game"):
			$PaddleHit.playing = true 
	
	if position.y > get_viewport().size.y:
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()
