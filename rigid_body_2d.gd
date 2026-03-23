extends RigidBody2D

func _draw() -> void:
	draw_circle(Vector2(0,0),5,Color(1,1,1))

var direction = 1
var velocidad = 100

func _ready() -> void:
	linear_velocity.x = velocidad * direction

func w_physics_process(delta: float) -> void:
	linear_velocity.x = velocidad * direction



func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		print("entro")
		direction *= -1
	pass # Replace with function body.
