extends RigidBody2D

onready var anim_tree := $AnimationTree
export var speed := 50.0
export var jump_speed := 100.0
 
func _process(delta):
    var input_vector = Vector2.ZERO
   
    input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed

    if input_vector == Vector2.ZERO:
        anim_tree.get("parameters/playback").travel("Idle")
    else:
        anim_tree.set("parameters/Kick/blend_position", input_vector.x)
        anim_tree.set("parameters/Headbutt/blend_position", input_vector.x) 
        anim_tree.set("parameters/Idle/blend_position", input_vector.x)
        anim_tree.set("parameters/Run/blend_position", input_vector.x)
        anim_tree.get("parameters/playback").travel("Run")
      
        apply_central_impulse(input_vector)
        
    if Input.is_action_just_pressed("ui_up"):
        anim_tree.get("parameters/playback").travel("Headbutt")
    if Input.is_action_just_pressed("ui_down"):
        anim_tree.get("parameters/playback").travel("Kick")
        
   # if Input.is_action_pressed("ui_down"):    
    


