extends Node

signal health_signal
signal health_starter
signal dead
  
func emit_health_starter(lives: Array):
    emit_signal("health_starter", lives)
    
func emit_health_signal(lives: Array):
     emit_signal("health_signal", lives)
    
func emit_dead_signal():
    emit_signal("dead")
