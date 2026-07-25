@tool 
class_name AfterImage2DFrame
extends Sprite2D


## A Single frame of the AfterImage2D Effect (Should be used by Plugin only!) 

## If this frame is allowed to be called to start fading 
var can_start : bool = true
var _after_image_parrent : AfterImage2D


func _process(delta: float) -> void:
	if(_after_image_parrent):
		if(not _after_image_parrent.frame_contiunity):
			update_sprite()

## Starts the fade visual & set can_start flag
func start_fade(do_fade : bool, time : float, final_offset : Vector2):
	if(can_start):
		can_start = false
		var tween : Tween = create_tween()
		tween.set_parallel()
		if(do_fade): tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), time)
		tween.tween_property(self, "position", position + final_offset, time)
		await tween.finished
		can_start = true


## Updates the image frame to match the bound sprite
func update_sprite():
	## Copy node data
	self.texture = _after_image_parrent.sprite_to_copy.texture
	self.frame = _after_image_parrent.sprite_to_copy.frame
	self.hframes = _after_image_parrent.sprite_to_copy.hframes
	self.vframes = _after_image_parrent.sprite_to_copy.vframes
	self.global_scale = _after_image_parrent.sprite_to_copy.global_scale
	self.global_rotation = _after_image_parrent.sprite_to_copy.global_rotation
