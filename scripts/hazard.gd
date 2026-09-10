extends Area2D

signal player_hit

var hit_once := false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not hit_once:
		hit_once = true
		player_hit.emit()
