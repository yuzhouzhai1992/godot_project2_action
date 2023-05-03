extends CharacterBody2D

var health = 100

func _ready():
	add_to_group("monster")

func take_hit(value:int):
	health = health - value
	$SFM.change_state(3)
	
