extends Node2D

func _ready():
    $Debugger.add_property($PlayerDino, "gravity_speed", "")
    $Debugger.add_property($PlayerDino, "arr_lives", "")
