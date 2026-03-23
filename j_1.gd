extends CharacterBody2D

# Velocidad de movimiento de la pala
@export var speed: float = 600.0

func _physics_process(_delta: float) -> void:
	# Reinicia la velocidad
	var direction = Vector2.ZERO
	
	# Detecta entrada de teclado para J1
	if Input.is_action_pressed("ui_up_j1"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down_j1"):
		direction.y += 1
		
	# Aplica la velocidad y mueve la pala
	velocity = direction * speed
	move_and_slide()
	
	# Mantiene la pala dentro de la pantalla
	# Puedes ajustar estos valores según el tamaño de tu pala y ventana
	position.y = clamp(position.y, 100.0, get_viewport_rect().size.y - 100.0)
