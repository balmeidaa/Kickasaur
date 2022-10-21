extends Node

signal health_signal
signal health_starter
signal dead

signal update_score

signal new_message
signal game_over
signal new_game

func new_game():
     emit_signal("new_game")
    
    
func game_over(score:int):
    emit_signal("game_over", score)

func new_message(message: String):
    emit_signal("new_message", message)
  
func emit_health_starter(lives: Array):
    emit_signal("health_starter", lives)
    
func emit_health_signal(lives: Array):
     emit_signal("health_signal", lives)
    
func emit_dead_signal():
    emit_signal("dead")
