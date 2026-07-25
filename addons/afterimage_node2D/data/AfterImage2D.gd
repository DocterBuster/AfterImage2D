@tool
extends Node2D


## Frame preload 
var image_frame_ref = preload("res://addons/afterimage_node2D/data/AfterImageFrame2D.tscn")


## Members
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

## The starting Alpha modulate of the sprite frame when it is displayed 
@export_range(0.0, 1.0) var starting_alpha : float = 1.0

@export_group("")
## The sprite to copy for the effect (Needs to be set for the effect to work!) 
@export var sprite_to_copy : Sprite2D 



### Non-Editor Members

## The array of loaded trail frames : with [0] representing the most recently (or soon to be) emited index of the trail and the last element being the oldest
var trail_objects : Array[AfterImage2DFrame] = []


#region Effect Population

## Updates the trail amount, called when trail_amount is changed 
func _update_trail_amount():
	
	if(trail_objects.size() < trail_amount):
		## Add objects from the trail starting at the backmost index
		for i in range(0, trail_amount - trail_objects.size()):
			var frame : AfterImage2DFrame = image_frame_ref.instantiate()
			trail_objects.append(frame)
			add_child(frame)
	elif(trail_objects.size() > trail_amount):
		## Remove objects from the trail starting at the backmost index
		for i in range(trail_objects.size() - 1, trail_amount - 1, -1):
			trail_objects[i].free()
			trail_objects.remove_at(i)

#endregion 


#region Visual Effect


func _process(delta: float) -> void:
	
	## How long to wait is dependent on the frame count and fade time 
	var next_wait_invertal : float = fade_time / trail_amount
	
	pass



#endregion 


## Hides all frames of the AfterImage2D object instantly 
func hide_all_frames() -> void:
	pass



func _enter_tree() -> void:
	pass
