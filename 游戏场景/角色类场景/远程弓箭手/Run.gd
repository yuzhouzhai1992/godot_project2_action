extends Base_State

@onready var ani:AnimationPlayer =$"../../AnimationPlayer"#状态动画
@onready var monster:CharacterBody2D =$"../.."#角色
#@onready var a1:RayCast2D = $"../../RightATKCheck"#攻击感应区域
#@onready var a2:RayCast2D = $"../../LeftATKCheck"#攻击感应区域

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var direct:Vector2=Vector2.RIGHT#初始是右移的
#var attack:bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	$"../../AnimatedSprite2D".play("run")


func do():
	#敌人角色移动右边缘检测
	if !is_instance_valid($"../../RightDownCast".get_collider()):#射线检测不到地面（没有对象与射线相交）(检测物无效)
		direct = Vector2.LEFT
		$"../../AnimatedSprite2D".flip_h=true#动画水平翻转
	#敌人角色左边缘检测
	elif !is_instance_valid($"../../LeftDownCast2".get_collider()):#射线检测不到地面（没有对象与射线相交）(检测物无效)
		direct = Vector2.RIGHT
		$"../../AnimatedSprite2D".flip_h=false#动画水平翻转
	
	#敌人角色右边感知检测
	
	if direct == Vector2.RIGHT:#敌人角色朝右且不为攻击状态时
		#var arr:Array = a1.get_collider()#a1获得身体数组
		if is_instance_valid($"../../RightATKCheck".get_collider()):#射线检测右方向有效物体
			var collision = $"../../RightATKCheck".get_collider()
			if collision.is_in_group("player"):
				get_parent().change_state(1)
				return

			
	#敌人角色左边感知检测
	elif  direct == Vector2.LEFT:#敌人角色朝左且不为攻击状态时
		if is_instance_valid($"../../LeftATKCheck".get_collider()):#射线检测左方向有效物体
			var collision = $"../../LeftATKCheck".get_collider()
			if collision.is_in_group("player"):
				get_parent().change_state(2)
				return
			#return	
	

	
	monster.velocity=direct*SPEED#移动方向和速度
	monster.velocity.y=gravity#y轴速度为重力
	monster.move_and_slide()



		
