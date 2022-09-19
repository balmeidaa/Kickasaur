extends Area2D

export var damage := 1


func _on_Spikes_body_entered(body):
    if body.has_method("_damage"):
        body._damage(damage)
