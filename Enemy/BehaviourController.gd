extends "StateMachine.gd"

func _ready():
    add_state("move_to")
    add_state("chase")
    call_deferred("set_state", states.idle)


func _state_logic(_delta):
    pass
    
func _get_transition(_delta):

    match(state):
        0:
            pass
        _:
            pass
