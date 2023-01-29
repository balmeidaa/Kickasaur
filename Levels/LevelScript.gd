extends Node2D

onready var player_spawn := $PlayerSpawn

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func get_player_spawn():
    return player_spawn.position
