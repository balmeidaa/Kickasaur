extends CanvasLayer

onready var label := $MarginContainer/Message as Label

onready var final_score := $MarginContainer/Score as Label
onready var continue_message := $MarginContainer/Continue as Label

onready var tween := $MarginContainer/Tween as Tween
onready var timer := $MarginContainer/Timer as Timer

const fade_time := 0.5
 
func _ready():
     EventHandler.connect("new_message", self, "change_label_text")
     EventHandler.connect("game_over", self, "game_over_text")
     EventHandler.connect("clear", self, "clear_text")
     final_score.hide()
     continue_message.hide()


func clear_text():
    label.text = ""

func continue_new_game():
     final_score.hide()
     continue_message.hide()
     label.hide()
    

func game_over_text(score:int):
    label.text = "Game Over"
    final_score.text = "Final Score: %s" % String(score)
    final_score.show()
    continue_message.show()
    tween.interpolate_property(label, "modulate:a", 0.1, 1, fade_time, Tween.TRANS_QUINT, Tween.EASE_IN)
    tween.start()
    

func change_label_text(new_text: String):
    label.text = new_text
    appear()
    

func appear():
    tween.interpolate_property(label, "modulate:a", 0.1, 1, fade_time, Tween.TRANS_QUINT, Tween.EASE_IN)
    tween.start()
    timer.start()  

func fade():
    tween.interpolate_property(label, "modulate:a", 1.0, 0.0, fade_time, Tween.TRANS_LINEAR)
    tween.start()   

 

func _on_Timer_timeout():
    fade()
