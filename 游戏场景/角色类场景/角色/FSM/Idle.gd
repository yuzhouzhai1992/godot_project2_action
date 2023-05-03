extends Base_State

@onready var player:CharacterBody2D = $"../.."

#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	$"../../AnimatedSprite2D".play("Idle")
	
func do():
	#未接触地面时，进入Fall状态(4)
	if !player.is_on_floor():
		get_parent().change_state(4)
		return
	#按键位移
	var vec:Vector2 =Vector2.ZERO
	vec.x =Input.get_axis("ui_left","ui_right")#get_axis按键输入左右分别为负和正
	#在地面且位移输入不为0，则进入Run状态
	if vec.x!=0:
		get_parent().change_state(1)
		return
	#在地面且按“跳”键，则进入Jump状态
	elif Input.is_action_just_released("跳"):
		get_parent().change_state(3)
		return
	#在地面且按“攻击”键，则进入Attack状态
	elif Input.is_action_just_released("攻击"):
		get_parent().change_state(2)
		return
	#角色状态未被转换时，获得向下的速度
	player.velocity=Vector2(0,1)
	#用于判断角色是否处于floor
	player.move_and_slide()
	
	
