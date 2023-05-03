extends Base_State

var direct:Vector2=Vector2.LEFT#初始是左移的

func enter():
	$"../../AnimatedSprite2D".play("ATK")
	$"../../AnimatedSprite2D".flip_h=true#动画水平翻转
	$"../../Audio/Attack".play()

func do():
	pass

#第8帧添加弓箭
func _on_animated_sprite_2d_frame_changed():#检测动画播放帧
	if $"../../AnimatedSprite2D".animation=="ATK":#播放攻击动画时
		if $"../../AnimatedSprite2D".frame==8:#第8帧放箭
			var sce=preload("res://游戏场景/角色类场景/远程弓箭手/弓箭/弓箭.tscn").instantiate()#定义方法立即实例化弓箭场景节点
			sce.position=$"../../LeftATK".global_position#获取全局位置
			sce.vec_x=direct.x#定义弓箭方向
			get_parent().add_child(sce)#添加弓箭场景


func _on_animated_sprite_2d_animation_finished():
	if $"../../AnimatedSprite2D".animation=="ATK":
		$"../../AnimatedSprite2D".frame=0#动画返回0帧，如满足条件可从头播放
		get_parent().change_state(0)#返回Run状态
