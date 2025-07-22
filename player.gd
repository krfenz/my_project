extends CharacterBody2D

# 移动参数
@export var walk_speed: float = 180.0
@export var run_speed: float = 280.0
@export var acceleration: float = 12.0
@export var deacceleration: float = 8.0
@export var friction: float = 0.8

# 引用
@onready var anim_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

# 状态
var current_speed = walk_speed
var is_running = false
var facing_direction = Vector2.RIGHT
var last_idle_direction = Vector2.DOWN

func _ready():
	# 确保动画正确初始化
	anim_sprite.play("idle_down")

func _physics_process(delta):
	# 处理输入
	var input_dir = Vector2(
		Input.get_action_strength("move_left") - Input.get_action_strength("move_right"),
		Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	)
	
	# 处理跑步
	is_running = Input.is_action_pressed("run")
	current_speed = run_speed if is_running else walk_speed
	
	# 计算移动速度
	if input_dir != Vector2.ZERO:
		facing_direction = input_dir.normalized()
		velocity = velocity.lerp(facing_direction * current_speed, delta * acceleration)
		last_idle_direction = facing_direction
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * deacceleration * friction)
	
	# 移动角色
	move_and_slide()
	
	# 更新动画
	update_animation()

func update_animation():
	# 确定动画方向字符串
	var direction_str = ""
	if abs(facing_direction.x) > abs(facing_direction.y):
		direction_str = "right" if facing_direction.x > 0 else "left"
	else:
		direction_str = "down" if facing_direction.y > 0 else "up"
	
	# 根据状态选择动画
	var anim_state = ""
	if velocity.length() > 10:
		anim_state = "walk_" + direction_str
		if is_running:
			anim_state = "run_" + direction_str
	else:
		anim_state = "idle_" + direction_str
	
	# 播放动画
	if anim_sprite.animation != anim_state:
		anim_sprite.play(anim_state)
