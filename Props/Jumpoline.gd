extends StaticBody2D

export var jumpoline_force := 800.0
onready var sprite := $AnimatedSprite as AnimatedSprite

func _on_JumpArea_body_entered(body):
     sprite.play("Spring") 
     body.apply_central_impulse(Vector2.UP * jumpoline_force)


func _on_AnimatedSprite_animation_finished():
    sprite.play("Idle") 
