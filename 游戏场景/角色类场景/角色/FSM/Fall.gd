extends Base_State

@onready var player:CharacterBody2D =$"../.."
@onready var ani_sprite2D:AnimatedSprite2D=$"../../AnimatedSprite2D"
var speed = 200

func enter():
	ani_sprite2D.play("Fall")
	
func do():
	if player.is_on_floor():
		get_parent().change_state(0)
		return
	
	var vec:Vector2 =Vector2.ZERO
	vec.x =Input.get_axis("ui_left","ui_right")
	player.velocity.x = vec.x*speed
	player.velocity.y = player.velocity.y+3
	player.move_and_slide()
