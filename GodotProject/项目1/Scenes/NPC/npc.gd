extends StaticBody2D
@onready var canvas_layer = $CanvasLayer
@export  var dialog_lines : Array[String]=["hello","who zre you","baiby"]
var dialog_index :int=0
var can_interact: bool = false


func _ready():
	canvas_layer.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		$AudioStreamPlayer.play()
		if dialog_index<dialog_lines.size():
			$CanvasLayer/DialogLabel.text=dialog_lines[dialog_index]
			dialog_index+=1
			canvas_layer.visible=true
			get_tree().paused=true
		else:
			dialog_index=0
			canvas_layer.visible=false
			get_tree().paused=false
			
