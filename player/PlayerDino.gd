extends RigidBody2D

onready var anim_tree := $AnimationTree
export var speed := 50.0

var lives := 3
var arr_lives := []
const gravity_speed_default := 35
 
var jump_speed := 700.0
var gravity := 1.0
var gravity_speed := 0.0

var is_grounded := true

const default_direction := 1
var kick_position:= Vector2()
var input_vector = Vector2()

var impulse := Vector2()
var body_temp = null

onready var tween := $Tween as Tween
const fade_time := 0.5
var score 

func _ready():
     
     update_animation_position(default_direction)
     reset_player()
     EventHandler.emit_health_starter(arr_lives)
     $Fall.set_autoplay(false)
    
    
    
func _process(delta):
    input_vector = Vector2.ZERO
    
    if is_player_alive():
        input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
        
        if input_vector == Vector2.ZERO:
            anim_tree.get("parameters/playback").travel("Idle")
        else:
            impulse.x = input_vector.x
            update_animation_position(input_vector.x)
            anim_tree.get("parameters/playback").travel("Run")
        
        if Input.is_action_just_pressed("ui_accept"):
            _apply_hit_impulse(body_temp,impulse)    
            anim_tree.get("parameters/playback").travel("Headbutt")    
        
        if Input.is_action_just_pressed("ui_down"):
            anim_tree.get("parameters/playback").travel("Kick")
            _apply_hit_impulse(body_temp,impulse)   
        
        if Input.is_action_just_pressed("ui_up") and is_grounded:
            _reset_gravity()
            apply_central_impulse(Vector2.UP *jump_speed)
        elif not is_grounded:
            
            gravity_speed += gravity + delta
            apply_central_impulse(Vector2.DOWN*gravity_speed)
            
    
    else:
        tween.interpolate_property(self, "modulate:a", 1.0, 0.1, fade_time, Tween.TRANS_QUINT, Tween.EASE_IN)
        tween.start()
        EventHandler.game_over(score)
        EventHandler.emit_dead_signal()
        self.set_process(false)

    apply_impulse(Vector2(),input_vector*speed)
        
func update_animation_position(direction):
    anim_tree.set("parameters/Hurt/blend_position",direction)
    anim_tree.set("parameters/Kick/blend_position",direction)
    anim_tree.set("parameters/Headbutt/blend_position", direction) 
    anim_tree.set("parameters/Idle/blend_position", direction)
    anim_tree.set("parameters/Run/blend_position", direction)

func _integrate_forces(state):
    var prev_state_is_ground = is_grounded
    is_grounded = state.get_contact_count() > 0 and int(state.get_contact_collider_position(0).y) >= int(global_position.y)
    if is_grounded:
        _reset_gravity()
        if not prev_state_is_ground:
            $Fall.play()


func _reset_gravity():
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
    anim_tree.get("parameters/playback").travel("Hurt")
   
    if is_player_alive():
        decrease_life(damage)
        EventHandler.emit_health_signal(arr_lives)  
   
        
#2 = full heart
#1 = half heart
#0 = empty heart
func decrease_life(value):
    var diff = 0
    var index = arr_lives.size()-1
    
    while index >= 0:
        
        diff = arr_lives[index] - abs(value)
        if diff >= 0:
            arr_lives[index] = diff
            break
        else:
            value = diff
            arr_lives[index] = 0
            
        index -= 1

func reset_player():
     score = 0
     for life in range(lives):
         arr_lives.append(2)
    
func is_player_alive():
    var life_counter = 0
    
    for life in arr_lives:
        life_counter += life
    
    return (life_counter > 0)


func _on_Fall_finished():
    pass # Replace with function body.
