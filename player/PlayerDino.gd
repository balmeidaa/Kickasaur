extends RigidBody2D

onready var anim_tree := $AnimationTree
export var speed := 50.0
var jump_speed := 700.0
var gravity := 1.0
var gravity_speed := 0.0
var lives := 3
const gravity_speed_default := 35
 
var is_grounded := true
const default_direction := 1
var kick_position:= Vector2()
var input_vector = Vector2()

var impulse := Vector2()
var body_temp = null



func _ready():
     EventHandler.emit_health_starter(lives)
     update_animation_position(default_direction)
    
func _process(delta):
    input_vector = Vector2.ZERO
    
    input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))

    if input_vector == Vector2.ZERO:
        anim_tree.get("parameters/playback").travel("Idle")
    else:
        impulse.x = input_vector.x
        update_animation_position(input_vector.x)
        anim_tree.get("parameters/playback").travel("Run")
      
        
    if Input.is_action_just_pressed("ui_up") and is_grounded:
        gravity_speed = gravity_speed_default
        apply_central_impulse(Vector2.UP *jump_speed)
    
    elif not is_grounded:
        
        gravity_speed += gravity + delta
        apply_central_impulse(Vector2.DOWN*gravity_speed)
        
          
    if Input.is_action_just_pressed("ui_accept"):
        #anim_tree.get("parameters/playback").travel("Hurt") 
        _apply_hit_impulse(body_temp,impulse)    
        anim_tree.get("parameters/playback").travel("Headbutt")    
    if Input.is_action_just_pressed("ui_down"):
        _apply_hit_impulse(body_temp,impulse)    
        anim_tree.get("parameters/playback").travel("Kick")
    
    apply_impulse(Vector2(),input_vector*speed)
        
func update_animation_position(direction):
    anim_tree.set("parameters/Hurt/blend_position",direction)
    anim_tree.set("parameters/Kick/blend_position",direction)
    anim_tree.set("parameters/Headbutt/blend_position", direction) 
    anim_tree.set("parameters/Idle/blend_position", direction)
    anim_tree.set("parameters/Run/blend_position", direction)

func _integrate_forces(state):
    is_grounded = state.get_contact_count() > 0 and int(state.get_contact_collider_position(0).y) >= int(global_position.y)
    if is_grounded:
        gravity_speed = gravity_speed_default


    
func _on_HurtboxKick_body_entered(body):
    impulse.y = -1
    body_temp = body

        
func _on_HurtboxHead_body_entered(body):
    impulse.y = -0.5
    body_temp = body

        
        
func _apply_hit_impulse(body, impulse_hit):
    if body and body.has_method("apply_central_impulse"):   
        body.apply_central_impulse(impulse_hit*900)


func _on_HurtboxKick_body_exited(body):
    body_temp = null


func _on_HurtboxHead_body_exited(body):
    body_temp = null
    
func _damage(damage):
    lives -= damage
    anim_tree.get("parameters/playback").travel("Hurt")
   
    if lives <= 0:
        EventHandler.emit_dead_signal()
    else:
        EventHandler.emit_health_signal(lives)
        
    
