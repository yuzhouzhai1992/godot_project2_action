extends Base_State

@onready var player:CharacterBody2D =$"../.."
@onready var ani_sprite2D:AnimatedSprite2D=$"../../AnimatedSprite2D"

var speed = 200
var jump_speed = -130
var jumping:bool = false

func enter():
	#播放跳跃前置动画
	ani_sprite2D.play("Prejump")
	#动画播放结束
	await ani_sprite2D.animation_finished
	ani_sprite2D.frame=0
	if ani_sprite2D.animation=="Prejump":
		$"../../Audio/jump".play()
		ani_sprite2D.play("Jump")
		jumping = true
		player.velocity.y=jump_speed
		
func do():
	if jumping:
		#向下移动时切换为下落状态
		if player.velocity.y>0:
			get_parent().change_state(4)
			return
		var vec:Vector2 = Vector2.ZERO
		vec.x =Input.get_axis("ui_left","ui_right")
		player.velocity.x = vec.x*speed
		player.velocity.y = player.velocity.y+2
		player.move_and_slide()

func exit():
	#下落时可能被怪物攻击，进入受击状态，此时y需要强制不让它继续上升
	player.velocity.y=0
	jumping=false
		
	
