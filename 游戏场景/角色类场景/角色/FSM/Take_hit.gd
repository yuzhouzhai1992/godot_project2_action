extends Base_State

@onready var player:Player =$"../.."
@onready var ani_sprite2D:AnimatedSprite2D=$"../../AnimatedSprite2D"
var speed = 200

func enter():
	$"../../Audio/take_hit".play()
	if player.health>0:
		ani_sprite2D.play("Take_hit")
	
	else :
		ani_sprite2D.play("Death")
		#死亡后停留3秒，发出死亡信号
		await get_tree().create_timer(3).timeout
		player.emit_signal("death")
		return
		
func do():
	pass
		


func _on_animated_sprite_2d_animation_finished():
	if ani_sprite2D.animation == "Take_hit":
		get_parent().change_state(0)
	#if ani_sprite2D.animation == "Death":
		#player.emit_signal("death")
