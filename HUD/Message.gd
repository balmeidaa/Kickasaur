extends CanvasLayer

onready var label := $MarginContainer/Message as Label
onready var tween := $MarginContainer/Tween as Tween
onready var timer := $MarginContainer/Timer as Timer

const fade_time := 0.5
 

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
