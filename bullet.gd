extends Area2D

@export var speed = 500
@export var lifetime = 2
@export var Damage = 10


func _ready() -> void:
	# Remove the bullet after its lifetime
	await get_tree().create_timer(lifetime).timeout
	queue_free()


func _process(delta: float) -> void:
	position += Vector2(cos(rotation), sin(rotation)) * speed * delta

func _on_Area2D_body_entered(body):
	if body.has_method("takeDamage"):
		body.takeDamage(Damage)
	queue_free()
