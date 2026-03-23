extends CharacterBody2D

# Velocidad de movimiento de la pala de la IA
@export var speed: float = 400.0 # Un poco más lenta que el jugador para que sea ganable

# Referencia a la pelota para que la IA sepa dónde está
@onready var pelota = $"../Pelota"

func _physics_process(_delta: float) -> void:
	# Reinicia la velocidad
	var direction = Vector2.ZERO
	
	# Lógica básica de IA: sigue a la pelota
	# Si la pelota está por encima, muévete hacia arriba
	if pelota.global_position.y < global_position.y:
		direction.y -= 1
	# Si la pelota está por debajo, muévete hacia abajo
	elif pelota.global_position.y > global_position.y:
		direction.y += 1
		
	# Aplica la velocidad y mueve la pala
	velocity = direction * speed
	move_and_slide()
	
	# Mantiene la pala dentro de la pantalla
	position.y = clamp(position.y, 100.0, get_viewport_rect().size.y - 100.0)
