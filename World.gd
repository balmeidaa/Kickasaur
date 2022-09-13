extends Node2D

func _ready():
    $Debugger.add_property($PlayerDino, "is_kicking", "")
    $Debugger.add_property($PlayerDino, "is_headbutting", "")
    $Debugger.add_property($PlayerDino, "impulse", "")
    $Debugger.add_property($PlayerDino, "input_vector", "")
