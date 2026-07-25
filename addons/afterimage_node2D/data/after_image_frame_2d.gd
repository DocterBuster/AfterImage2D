@tool 
class_name AfterImage2DFrame
extends Sprite2D


## A Single frame of the AfterImage2D Effect (Should be used by Plugin only!) 

## If this frame is allowed to be called to start fading 
var can_start : bool = true



## Starts the fade visual & set can_start flag
func start_fade(time : float, final_offset : Vector2):
	if(can_start):
		can_start = false
		var tween : Tween = create_tween()
		tween.set_parallel()
		tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), time)
		tween.tween_property(self, "position", position + final_offset, time)
		await  tween.finished
		can_start = true
