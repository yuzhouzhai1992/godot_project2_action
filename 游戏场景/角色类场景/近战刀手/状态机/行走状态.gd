extends Base_State

@onready var ani:AnimationPlayer =$"../../AnimationPlayer"#状态动画
@onready var monster:CharacterBody2D =$"../.."#角色
@onready var a1:Area2D = $"../../AttackCheck/A1"#攻击感应区域

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direct:Vector2=Vector2.RIGHT#初始是右移的

const SPEED = 200.0
const JUMP_VELOCITY = -400.0



func enter():
	ani.play("走动")
	
func do():
	#敌人角色移动右边缘检测
	if !is_instance_valid($"../../RightDownCast".get_collider()):#射线检测不到地面（没有对象与射线相交）(检测物无效)
		direct = Vector2.LEFT
		$"../../AttackCheck".scale.x=-1#转向后，感应区域也要转向
		$"../../AnimatedSprite2D".flip_h=true#动画水平翻转
	#敌人角色左边缘检测
	elif !is_instance_valid($"../../LeftDownCast2".get_collider()):#射线检测不到地面（没有对象与射线相交）(检测物无效)
		direct = Vector2.RIGHT
		$"../../AttackCheck".scale.x=1#转向后，感应区域也要转向
		$"../../AnimatedSprite2D".flip_h=false#动画水平翻转
	
	#判断敌人感应
	var arr:Array = a1.get_overlapping_bodies()#a1获得身体数组
	if arr.size()>0:#身体数组不为空时
		#感应到的是玩家时
		for i in arr:
			if i.is_in_group("player"):
				get_parent().change_state(1)#状态转换为第二个子节点Attack，也就是切换为Attack状态
				return#此时状态切换，不继续执行行走
		
	#移动的方向和速度	
	monster.velocity=direct*SPEED
	monster.velocity.y=gravity#y轴速度为重力
	monster.move_and_slide()
