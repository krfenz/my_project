extends StaticBody2D

@export var buttons_needed :int =1

var button_pressed :int=0

func _on_puzzle_button_pressed():
	button_pressed +=1
	
	if button_pressed >= buttons_needed:	
		visible = false
		$CollisionShape2D.set_deferred("disabled",true)


func _on_puzzle_button_unpressed():
	button_pressed -=1
	
	if button_pressed < buttons_needed:	
		visible =true
		$CollisionShape2D.set_deferred("disabled",false)
