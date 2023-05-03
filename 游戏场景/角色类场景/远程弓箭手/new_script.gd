extends Base_State

@onready var ani:AnimationPlayer =$"../../AnimationPlayer"#状态动画
@onready var monster:CharacterBody2D =$"../.."#角色
#@onready var a1:RayCast2D = $"../../RightATKCheck"#攻击感应区域
#@onready var a2:RayCast2D = $"../../LeftATKCheck"#攻击感应区域

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var direct:Vector2=Vector2.RIGHT#初始是右移的
var attack:bool = false
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
	
	if direct == Vector2.RIGHT&&attack==false:#敌人角色朝右且不为攻击状态时
		#var arr:Array = a1.get_collider()#a1获得身体数组
		if is_instance_valid($"../../RightATKCheck".get_collider()):#射线检测右方向有效物体
			var collision = $"../../RightATKCheck".get_collider()
			if collision.is_in_group("player"):
				attack = true# 进入攻击状态
				$"../../AnimatedSprite2D".play("ATK")#检测到后播放ATK动画
			#return
			
	#敌人角色左边感知检测
	if direct == Vector2.LEFT&&attack==false:#敌人角色朝左且不为攻击状态时
		if is_instance_valid($"../../LeftATKCheck".get_collider()):#射线检测左方向有效物体
			var collision = $"../../LeftATKCheck".get_collider()
			if collision.is_in_group("player"):
				attack = true# 进入攻击状态
				$"../../AnimatedSprite2D".play("ATK")#检测到后播放ATK动画
				$"../../AnimatedSprite2D".flip_h=true#动画水平翻转
			#return	
	
	
	if attack == true:#攻击状态不进行移动
		return
	
	monster.velocity=direct*SPEED#移动方向和速度
	monster.velocity.y=gravity#y轴速度为重力
	monster.move_and_slide()

#第8帧添加弓箭
func _on_animated_sprite_2d_frame_changed():#检测动画播放帧
	if $"../../AnimatedSprite2D".animation=="ATK":#播放攻击动画时
		if $"../../AnimatedSprite2D".frame==8:#第8帧放箭
			var sce=preload("res://游戏场景/角色类场景/远程弓箭手/弓箭/弓箭.tscn").instantiate()#定义方法立即实例化弓箭场景节点
			if direct == Vector2.RIGHT:#判断方向			
				sce.position=$"../../RightATK".global_position#获取全局位置
			elif direct == Vector2.LEFT:#判断方向点
				sce.position=$"../../LeftATK".global_position#获取全局位置
			sce.vec_x=direct.x#定义弓箭方向
			get_parent().add_child(sce)#添加弓箭场景


func _on_animated_sprite_2d_animation_finished():
	if $"../../AnimatedSprite2D".animation=="ATK":
		$"../../AnimatedSprite2D".frame=0#动画返回0帧，如满足条件可从头播放
