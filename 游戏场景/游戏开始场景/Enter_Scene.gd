extends TextureRect

signal  game_start

func  victory():
	$CenterContainer/VBoxContainer/Label.text = "恭喜通关"
	#显示场景根节点
	show()
	
func death():
	$CenterContainer/VBoxContainer/Label.text = "胜败乃兵家常事\n请大侠重新来过"
	#显示场景根节点
	show()


func _on_start_pressed():
	hide()
	emit_signal("game_start")


func _on_exit_pressed():
	get_tree().quit()
