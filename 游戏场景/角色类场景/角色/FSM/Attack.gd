extends Base_State

var attack_index :int = 0
@onready var ani_sprite2D:AnimatedSprite2D=$"../../AnimatedSprite2D"

func enter():
	$Timer.stop()
	if attack_index == 0:
		$"../../AnimationPlayer".play("攻击1")
	elif attack_index ==1 :
		$"../../AnimationPlayer".play("攻击2")
	else :
		$"../../AnimationPlayer".play("攻击3")
		
		
func do ():
	pass
	
func exit():
	ani_sprite2D.frame=0
	$"../../AnimationPlayer".stop()
	

func _on_timer_timeout():
	#及时结束后，攻击阶段归0（在限定帧内输入动作即可放出连招）
	attack_index = 0
	
#攻击检测
func attack_check():
	var arr = []
	if attack_index == 0:
		arr = $"../../Attack_Check/A1".get_overlapping_bodies()
	elif attack_index == 1:
		arr =$"../../Attack_Check/A2".get_overlapping_bodies()
	else :
		arr =$"../../Attack_Check/A3".get_overlapping_bodies()
	
	#若是monster，则对方收到10点伤害
	for i in arr :
		if i.is_in_group("monster"):
			i.take_hit(10)


func _on_animated_sprite_2d_animation_finished():
	#判断播放的动画的名称前6个字符串是否为Attack
	if ani_sprite2D.animation.left(6)=="Attack":
		attack_index += 1
		#为3时归零
		if attack_index ==3:
			attack_index = 0
		$Timer.start(0.25)
		get_parent().change_state(0)
