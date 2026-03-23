extends CharacterBody2D

@export var speed: float = 600.0

func _physics_process(_delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
		
	velocity = direction * speed
	move_and_slide()
	
	
