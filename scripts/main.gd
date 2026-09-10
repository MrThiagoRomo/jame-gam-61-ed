extends Node2D

const TOTAL_PICKUPS: int = 3

var score: int = 0
var won: bool = false
var exit_opened: bool = false

@onready var player: CharacterBody2D = $Player
@onready var score_label: Label = $HUD/ScoreLabel
@onready var exit: Area2D = $Exit 

func _ready() -> void:
	for pickup in $Pickups.get_children():
		pickup.collected.connect(_on_pickup_collected)
	for hazard in $Hazards.get_children():
		hazard.player_hit.connect(_restart_run)
	_update_score()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		_restart_run()

func _on_pickup_collected() -> void:
	if won:
		return
	score += 1
	if score >= TOTAL_PICKUPS:
		exit_opened = true
	else:
		_update_score()

func _update_score() -> void:
	score_label.text = "Coletas: %d/%d" % [score, TOTAL_PICKUPS]

func _win() -> void:
	won = true
	player.velocity = Vector2.ZERO
	player.set_physics_process(false)
	score_label.text = "Vitória! Pressione R para reiniciar"

func _restart_run() -> void:
	get_tree().reload_current_scene()

func _on_exit_body_entered(body: Node2D) -> void:
	if body == player and exit_opened:
		_win()