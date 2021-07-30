extends Camera2D

var target = null

# makes the camera follow the player
func _physics_process(delta):
    if target:
        position = target.position
