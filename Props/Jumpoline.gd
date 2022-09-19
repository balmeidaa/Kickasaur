extends StaticBody2D

export var jumpoline_force := 800.0
onready var sprite := $AnimatedSprite as AnimatedSprite
var jump_direction := Vector2()

func _ready():
    jump_direction = Vector2(sin(rotation_degrees) ,-cos(rotation_degrees))


func _on_JumpArea_body_entered(body):
     sprite.play("Spring") 
     body.apply_central_impulse(jump_direction * jumpoline_force)


func _on_AnimatedSprite_animation_finished():
    sprite.play("Idle") 
