extends Node2D

var game_over = false
onready var menu := $Menu
onready var message := $Message

func _ready():
    EventHandler.connect("game_over", self, "game_over_wait")
    $Debugger.add_property(self, "game_over", "")

 

func game_over_wait(score):
    game_over = true
    
    

func _input(event):
    if game_over and (event is InputEventKey and event.pressed):
        message.continue_new_game()
        menu.show_ui()
        game_over = false

