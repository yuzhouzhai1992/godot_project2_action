extends Base_State

var speed = 400
@onready var player:CharacterBody2D =$"../.."
@onready var ani_sprite2D:AnimatedSprite2D=$"../../AnimatedSprite2D"

#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	ani_sprite2D.play("run")
	
func do():
	#未接触地面时，进入Fall状态(4)
	if !player.is_on_floor():
		get_parent().change_state(4)
		return
	#在地面且按“跳”键，则进入Jump状态
	elif Input.is_action_just_released("跳"):
		get_parent().change_state(3)
		return
	#在地面且按“攻击”键，则进入Attack状态
	elif Input.is_action_just_released("攻击"):
		get_parent().change_state(2)
		return
	
	#按键位移
	var vec:Vector2 =Vector2.ZERO
	vec.x =Input.get_axis("ui_left","ui_right")#get_axis按键输入左右分别为正和负
	#若移动趋势为0，则返回Idle状态
	if vec.x == 0:
		get_parent().change_state(0)
		return
	
	#输入ui_right时，动画不翻转，攻击检测区不翻转
	elif  vec.x>0:
		ani_sprite2D.flip_h=false
		$"../../Attack_Check".scale.x=1
	#输入ui_left时，动画翻转，攻击检测区翻转
	else :
		ani_sprite2D.flip_h=true
		$"../../Attack_Check".scale.x=-1
	#跑动速度与方向
	player.velocity=vec*speed
	#
	player.velocity.y = 1
	player.move_and_slide()


