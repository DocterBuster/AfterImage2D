@tool
## An object that spawns copies of a sprite and fades them out to produce a visual effect 
class_name AfterImage2D
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
## If if to use frame_color_overide to replace the color of the sprite frame with a monochrome version 
@export var overide_frame_color : bool = true 
## if overide_frame_color is true, the color to make the frames apear 
@export_color_no_alpha var frame_color_overide : Color = Color(1.0, 1.0, 1.0, 1.0)

@export_group("")
## The sprite to copy for the effect (Needs to be set for the effect to work!) 
@export var sprite_to_copy : Sprite2D 
## If the effect should be turned on  
@export var emiting : bool = true



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

var wait_finished = true

func _process(delta: float) -> void:
	
	if(emiting and wait_finished):
		## How long to wait is dependent on the frame count and fade time 
		var next_wait_invertal : float = fade_time / trail_amount
		
		
		## Select the first index of the array and copy data to it
		_copy_sprite_to_index(0)
		
		## Then tell that frame to play!
		trail_objects[0].start_fade(fade_time)
		## After priming, send the index to the back of the array! 
		trail_objects.push_back(trail_objects.pop_front())
		
		## lastly, wait for the interal to pass
		wait_finished = false
		await get_tree().create_timer(next_wait_invertal).timeout
		wait_finished = true

## (INTERNAL HELPER) Copies the selected sprite's data to an index of the array (typicaly 0) 
func _copy_sprite_to_index(index : int):
	trail_objects[0].texture = sprite_to_copy.texture
	trail_objects[0].position = global_position ## Postion of emmiter 
	trail_objects[0].global_scale = sprite_to_copy.global_scale
	trail_objects[0].modulate = Color(1.0, 1.0, 1.0, starting_alpha)
	
	## Set shadr param
	trail_objects[0].material.set_shader_parameter("enable", overide_frame_color)
	trail_objects[0].material.set_shader_parameter("monochrome_color", frame_color_overide)


#endregion 


## Hides all frames of the AfterImage2D object instantly 
func hide_all_frames() -> void:
	pass
