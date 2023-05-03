extends TileMap

signal victory
signal failed

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("victory")
		queue_free()



func _on_player_death():
	emit_signal("failed")
	queue_free()
