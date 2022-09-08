extends RigidBody2D

onready var anim_tree := $AnimationTree

func _process(delta):
    var input_vector = Vector2.ZERO
   
    input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_vector.y = Input.get_action_strength("ui_up")
    input_vector = input_vector.normalized()
    
    if input_vector == Vector2.ZERO:
        $AnimationTree.get("parameters/playback").travel("Idle")
    else:
        $AnimationTree.get("parameters/playback").travel("Run")
        #move_and_slide(input_vector * speed)
        $AnimationTree.set("parameters/Idle/blend_position", input_vector.x)
        $AnimationTree.set("parameters/Run/blend_position", input_vector.x)
