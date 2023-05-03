extends Base_State

@onready var monster:CharacterBody2D =$"../.."
@onready var ani_sprite2D:AnimatedSprite2D=$"../../AnimatedSprite2D"
var speed = 200

func enter():
	$"../../Audio/take_hit".play()
	if monster.health>0:
		ani_sprite2D.play("take_hit")
	
	else :
		ani_sprite2D.play("death")
		return
		
func do():
	pass
		


func _on_animated_sprite_2d_animation_finished():
	if ani_sprite2D.animation == "take_hit":
		get_parent().change_state(0)
	#如果播的是死亡动画，则删除对象
	if ani_sprite2D.animation =="death":
		monster.queue_free()
		
