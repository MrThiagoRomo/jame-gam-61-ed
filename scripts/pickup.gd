extends Area2D

signal collected

var was_collected := false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not was_collected:
		was_collected = true
		collected.emit()
		queue_free()
