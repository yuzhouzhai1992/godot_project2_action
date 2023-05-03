extends Base_State

func enter():
	if $Timer.is_stopped():
		$"../../AnimationPlayer".play("攻击1")
	else :
		$"../../AnimationPlayer".play("攻击2")



func do():
	pass
	
func attack1_check():
	var arr =$"../../AttackCheck/A1".get_overlapping_bodies()
	attack_bodie(arr)

	
func attack2l_check():
	var arr =$"../../AttackCheck/A2l".get_overlapping_bodies()
	attack_bodie(arr)
	
func attack2r_check():
	var arr =$"../../AttackCheck/A2r".get_overlapping_bodies()
	attack_bodie(arr)

func attack_bodie(arr:Array):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(10)
		
	

func _on_animated_sprite_2d_animation_finished():#敌人发动攻击1后的0.25秒，如继续攻击，会切换为攻击2
	if $"../../AnimatedSprite2D".animation =="ATK1":#攻击1动画播放完成后，启动Timer
		$Timer.start(0.25)
	if $"../../AnimatedSprite2D".animation =="ATK1"||$"../../AnimatedSprite2D".animation =="ATK2":#若播放完成的是攻击动画
		$"../../AnimatedSprite2D".frame=0#动画返回0帧，如满足条件可从头播放
		get_parent().change_state(0)#返回Run状态

