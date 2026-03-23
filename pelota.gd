extends CharacterBody2D

# Velocidad inicial de la pelota
@export var initial_speed: float = 600.0
# Incremento de velocidad después de cada golpe con una pala
@export var speed_increment: float = 20.0
var current_speed: float

# Variable para rastrear la dirección del movimiento
var direction = Vector2.ZERO

func _draw():
	draw_circle(Vector2.ZERO, 8, Color.WHITE)

func _ready() -> void:
	# Inicializa la velocidad
	current_speed = initial_speed
	# Inicia la pelota
	reset_ball(true)

func _physics_process(delta: float) -> void:
	# Mueve la pelota
	var collision = move_and_collide(direction * current_speed * delta)
	
	# Si hay colisión
	if collision:
		var collider = collision.get_collider()
		
		# Si choca con una pala (J1 o J2)
		if collider.name == "J1" or collider.name == "J2":
			# Rebota
			direction = direction.bounce(collision.get_normal())
			# Incrementa la velocidad
			current_speed += speed_increment
			
			# Detalle para un "buen Pong": curva el rebote según dónde golpee la pala
			var angle_adjustment = (global_position.y - collider.global_position.y) / (100.0 / 2.0) # Ajusta 100.0 al alto de tu pala
			direction.y = angle_adjustment * 0.5 # Factor de suavizado para el ángulo
			
		# Si choca con un muro (MuroSuperior o MuroInferior)
		elif collider.name == "MuroSuperior" or collider.name == "MuroInferior":
			# Rebota
			direction = direction.bounce(collision.get_normal())

# Función para reiniciar la pelota al centro
func reset_ball(move_right: bool) -> void:
	# Centra la pelota
	global_position = get_viewport_rect().size / 2.0
	# Restablece la velocidad
	current_speed = initial_speed
	
	# Elige una dirección inicial semi-aleatoria
	var angle = randf_range(-45, 45) # Ángulo aleatorio
	var initial_direction = Vector2.RIGHT.rotated(deg_to_rad(angle))
	
	if not move_right:
		initial_direction.x *= -1 # Sirve hacia el otro lado
		
	direction = initial_direction
