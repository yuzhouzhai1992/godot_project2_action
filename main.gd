extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enter_scene_game_start():
	var s = preload("res://游戏场景/地图场景/地图.tscn").instantiate()
	#收到victory信号后，调用$Enter_Scene的victory函数
	s.connect("victory",Callable($Enter_Scene,"victory"))
	
	s.connect("failed",Callable($Enter_Scene,"death"))
	add_child(s)
