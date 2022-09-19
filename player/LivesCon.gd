extends MarginContainer
export (String, FILE, '*.png') var full_heart
export (String, FILE, '*.png') var half_heart
export (String, FILE, '*.png') var empty_heart
const  offset_x := 55.0
export var sprite_scale := Vector2(3.0,3.0)
export var sprite_pos := 0.0
var array_hearts = []
var full_life := 0

func _ready():
    EventHandler.connect("health_starter", self, "load_hearts")
    EventHandler.connect("health_signal", self, "update_heart")

func load_hearts(lives):
    full_life = lives
    
    for heart in range(lives):
        var sprite = Sprite.new()
        sprite.scale = sprite_scale
        sprite.position = Vector2(sprite_pos, 0.0)
        sprite.texture = load(full_heart)
        sprite_pos += offset_x
        sprite.centered = false
 
        array_hearts.append(sprite)
        add_child(sprite)
                

func update_heart(lives):
 
    #full hearts
    for heart in range(full_life-1):
        if heart <= lives:
            array_hearts[heart].texture = load(full_heart)
        else:
            print('aas')
            array_hearts[heart].texture = load(empty_heart)
        
 
        
