extends MarginContainer
export (String, FILE, '*.png') var full_heart
export (String, FILE, '*.png') var half_heart
export (String, FILE, '*.png') var empty_heart
const  offset_x := 55.0
export var sprite_scale := Vector2(3.0,3.0)
export var sprite_pos := 0.0
var array_hearts = [] #sprite object handlers
var full_life := 0

func _ready():
    EventHandler.connect("health_starter", self, "load_hearts")
    EventHandler.connect("health_signal", self, "update_heart")

func load_hearts(lives):
    full_life = lives.size()
    
    for heart in lives:
        var sprite = Sprite.new()
        sprite.scale = sprite_scale
        sprite.position = Vector2(sprite_pos, 0.0)
        sprite.texture = load(full_heart)
        sprite_pos += offset_x
        sprite.centered = false
         
        array_hearts.append(sprite)
        add_child(sprite)
       

func update_heart(lives):
     var len_arr = array_hearts.size()
    
     for index in range(len_arr):

        match (lives[index]):
            2:
                array_hearts[index].texture = load(full_heart)
            1:
                array_hearts[index].texture = load(half_heart)
            0:
                array_hearts[index].texture = load(empty_heart)
        
 
        
