extends Node

onready var tilemap = $TileMap
onready var player = $Player
onready var menu = $menu
onready var menucon = $menu/Control
onready var cont = $Control/Control
onready var cam = $Player/Cam
var pause = false

var pos = Vector2()

# initialize menu
func _ready():
    menucon.visible = false
    menu.set_zoom(cam.zoom.x)
    menu.set_length(tilemap.length)

# checks if player is on the end of the tilemap
# if so make a new street
func _physics_process(delta): 
    if tilemap.end != null:
        pos = tilemap.world_to_map(player.position)
        if pos == tilemap.end:
            tilemap.end = null
            tilemap.clear()
            tilemap.makestreet()

# used to show pause menu and pause the player
func _on_pause():
    pause = !pause
    player.get_tree().paused = pause
    menucon.visible = pause
    cont.visible = !pause
    
# gets called when the length setting is changed
func _on_menu_length(v):
    tilemap.length = v
    
# gets called when the zoom setting is changed
func _on_menu_zoom(v):
    cam.zoom = Vector2(v,v)
