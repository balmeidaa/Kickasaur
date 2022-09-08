extends RigidBody2D

onready var anim_tree := $AnimationTree
export var speed := 50.0
export var jump_speed := 1200.0
export var gravity := 10.0
var gravity_speed := 0.0
 
var is_grounded := true

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
      
        
    if Input.is_action_just_pressed("ui_up") and is_grounded:
        gravity_speed = 0.0
        apply_central_impulse(Vector2.UP *jump_speed)
        anim_tree.get("parameters/playback").travel("Headbutt")
    elif not is_grounded:

        gravity_speed += gravity + delta
        apply_central_impulse(Vector2.DOWN*gravity_speed)
        
          
        
    if Input.is_action_just_pressed("ui_down"):
        anim_tree.get("parameters/playback").travel("Kick")
    
    apply_impulse(Vector2(),input_vector)
        
  

func _integrate_forces(state):
    is_grounded = state.get_contact_count() > 0 and int(state.get_contact_collider_position(0).y) >= int(global_position.y)


