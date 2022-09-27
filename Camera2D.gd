extends Camera2D

onready var tween := $Tween
onready var player := $"../PlayerDino"

var  player_pos := Vector2()

const anim_time:= 0.5


func _ready():
    player_pos = player.get_global_position()
    global_position = player_pos


func follow_player():
    tween.interpolate_property(self, "global_position", global_position, player_pos, anim_time,
        Tween.TRANS_LINEAR)
    tween.start()
    


func _physics_process(delta):
    player_pos = player.get_global_position()
    follow_player()


    
    



