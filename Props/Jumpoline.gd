extends StaticBody2D

var jumpoline_force := 3.0
const jump_spring := 1000
onready var sprite := $AnimatedSprite as AnimatedSprite
onready var boing := $BoingSound
var jump_direction := Vector2()

func _ready():
    jump_direction = Vector2(sin(rotation_degrees) ,-cos(rotation_degrees))


func _on_JumpArea_body_entered(body):
     sprite.play("Spring") 
     boing.play()
     body.apply_central_impulse(jump_direction * jumpoline_force * jump_spring)


func _on_AnimatedSprite_animation_finished():
    sprite.play("Idle") 
