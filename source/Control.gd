extends CanvasLayer

var right = false
var left = false
var up = false
var down = false
signal right
signal left
signal up
signal down

func _ready():
    pass



func _on_left_button(extra_arg_0):
    emit_signal("left",extra_arg_0)


func _on_right_button(extra_arg_0):
    emit_signal("right",extra_arg_0)


func _on_down_button(extra_arg_0):
    emit_signal("down",extra_arg_0)


func _on_up_button(extra_arg_0):
    emit_signal("up",extra_arg_0)
