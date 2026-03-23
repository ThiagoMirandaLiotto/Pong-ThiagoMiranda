extends Node2D

var score1: int = 0
var score2: int = 0

@onready var label_score1 = $LabelScore1
@onready var label_score2 = $LabelScore2

@onready var pelota = $Pelota

func _ready() -> void:
	label_score1.text = "0"
	label_score2.text = "0"
	
	# Conecta las señales de las Area2D para los goles
	$Area2DPlayer1.connect("body_entered", _on_Area2DPlayer1_body_entered)
	$Area2DPlayer2.connect("body_entered", _on_Area2DPlayer2_body_entered)

# Función que se llama cuando un cuerpo (la pelota) entra en la zona de gol 1 (izquierda)
func _on_Area2DPlayer1_body_entered(_body: Node) -> void:
	# Gol para el Jugador 2 (IA)
	score2 += 1
	update_score_labels()
	# Reinicia la pelota, sirviendo hacia el Jugador 1
	pelota.call_deferred("reset_ball", true)

# Función que se llama cuando un cuerpo (la pelota) entra en la zona de gol 2 (derecha)
func _on_Area2DPlayer2_body_entered(_body: Node) -> void:
	# Gol para el Jugador 1
	score1 += 1
	update_score_labels()
	# Reinicia la pelota, sirviendo hacia el Jugador 2
	pelota.call_deferred("reset_ball", false)

# Actualiza el texto de los marcadores
func update_score_labels() -> void:
	label_score1.text = str(score1)
	label_score2.text = str(score2)
