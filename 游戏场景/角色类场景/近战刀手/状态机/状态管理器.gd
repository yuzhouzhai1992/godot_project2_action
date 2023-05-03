class_name State_Manager

extends Node

var states_array:Array=[]#
@onready var current:Base_State =$Run

func  _ready():
	#获取子节点
	states_array =get_children()
	current.enter()
	
func _physics_process(delta):
	#处理状态
	current.do()
	
func change_state(id:int)->void:#状态转换函数
	#运行退出函数
	current.exit()
	#更新状态
	current = states_array[id]
	#进入状态
	current.enter()
