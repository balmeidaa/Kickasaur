extends CanvasLayer

onready var container := $ContainerUI

func _ready():
    container.hide()

func show_ui():
    container.show()

func hide_ui():
    container.hide()

func _on_Credits_pressed():
    pass # Replace with function body.


func _on_New_Game_pressed():
    hide_ui()
    EventHandler.new_game()
