@tool
extends Node2D


## Frame preload 
var image_frame_ref = preload("res://addons/afterimage_node2D/data/AfterImageFrame2D.tscn")

@export_group("Editor")
## If the effect should play in the editor
@export var play_in_editor : bool = false 

@export_group("Frame Properties")
## Should the effect fade at all? (Only disable if you are using the system for another purpose!) 
@export var do_fade = true
## How many frames are generated for the trail  
@export var trail_amount : int = 1:
	set(value):
		trail_amount = value
		_update_trail_amount()
## How long should the fade be? 
@export var fade_time : float = 1.0


#region Effect Population

## Updates the trail amount, called when trail_amount is changed 
func _update_trail_amount():
	pass




#endregion 


#region Visual Effect


func _process(delta: float) -> void:
	pass



#endregion 


## Hides all frames of the AfterImage2D object instantly 
func hide_all_frames() -> void:
	pass



func _enter_tree() -> void:
	pass
