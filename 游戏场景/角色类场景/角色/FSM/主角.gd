class_name Player

extends CharacterBody2D

#定义并导出health
@export var health = 100

signal death

func _ready():
	#加入player组，以便敌人进行检测
	self.add_to_group("player")
	$CanvasLayer/TextureProgressBar.max_value=health
	
func take_hit(value:int):
	health = health - value
	$CanvasLayer/TextureProgressBar.value = health
	$FSM.change_state(5)
	
