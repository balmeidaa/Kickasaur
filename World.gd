extends Node2D

var game_over = false

func _ready():
    EventHandler.connect("game_over", self, "game_over_wait")
    $Debugger.add_property($PlayerDino, "arr_lives", "")

 

func _input(event):
    if game_over and (event is InputEventKey and event.pressed):
        pass
        #show menu
