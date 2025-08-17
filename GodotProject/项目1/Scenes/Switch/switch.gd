extends StaticBody2D
signal switch_activated
signal switch_deactivated
var can_interact: bool = false
var is_activated: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		$AudioStreamPlayer.play()
		if is_activated:
			deactive_switch()
		else:
			active_switch()
	  
func active_switch():
	$AnimatedSprite2D.play("activited")		
	switch_activated.emit()
	is_activated=true
func deactive_switch():
	$AnimatedSprite2D.play("deactivated")
	switch_deactivated.emit()
	is_activated=false
	
