extends Area2D

var vec_x:float=1.0
var speed:float=5

func _ready():
	if vec_x<0:#判断朝向
		self.scale.x=-1#调整本节点scale，左右翻转

func  _physics_process(delta):
	self.position.x+=vec_x*speed#弓箭飞行速度
	var arr =$".".get_overlapping_bodies()
	attack_bodie(arr)
	

func attack_bodie(arr:Array):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(10)
			self.queue_free()

#弓箭时间存在超过5秒后自动删除
func _on_timer_timeout():
	queue_free()
			


