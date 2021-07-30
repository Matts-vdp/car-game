extends CanvasLayer

signal length
signal zoom
onready var zoom_slider = $Control/VBoxContainer/HBoxContainer/zooms
onready var length_slider = $Control/VBoxContainer/HBoxContainer2/lengts

func _on_lengts_value_changed(value):
    emit_signal("length", value)


func _on_zooms_value_changed(value):
    emit_signal("zoom", value)

func set_zoom(value):
    zoom_slider.value = value
    
func set_length(value):
    length_slider.value = value
