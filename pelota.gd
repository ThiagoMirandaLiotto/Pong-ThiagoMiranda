extends CharacterBody2D

# Velocidad inicial de la pelota
@export var initial_speed: float = 300.0
# Incremento de velocidad después de cada golpe con una pala
@export var speed_increment: float = 20.0
var current_speed: float

# Variable para rastrear la dirección del movimiento
var direction = Vector2.ZERO

func _draw():
	draw_circle(Vector2.ZERO, 8, Color.WHITE)

func _ready() -> void:
	current_speed = initial_speed
	reset_ball(true)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * current_speed * delta)
	
	if collision:
		var collider = collision.get_collider()
		
# Si choca con una pala (J1 o J2)
		if collider.name == "J1" or collider.name == "J2":
			# Rebota
			direction = direction.bounce(collision.get_normal())
			# Incrementa la velocidad
			current_speed += speed_increment
			
			# Calcula el rebote curvo
			var angle_adjustment = (global_position.y - collider.global_position.y) / (100.0 / 2.0)
			direction.y = angle_adjustment * 0.5 
			
			# PARA SOLUCIONAR EL FRENO DE LA PELOTA AL TCAR CON J1 o j2.
			direction = direction.normalized()
			
		# Si choca con un muro (MuroSuperior o MuroInferior)
		elif collider.name == "MuroSuperior" or collider.name == "MuroInferior":
			direction = direction.bounce(collision.get_normal())

# Función para reiniciar la pelota al centro
func reset_ball(move_right: bool) -> void:
	# Centra la pelota
	global_position = get_viewport_rect().size / 2.0
	# Restablece la velocidad
	current_speed = initial_speed
	
	var angle = randf_range(-45, 45) # aleatorio
	var initial_direction = Vector2.RIGHT.rotated(deg_to_rad(angle))
	
	if not move_right:
		initial_direction.x *= -1 # hacia el otro lado
		
	direction = initial_direction
