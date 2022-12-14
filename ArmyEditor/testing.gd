extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var defines = preload("res://defines.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	EZStorage.store("test","test", save_some_data())
	load_some_data()
func save_some_data():
	var name = "aaa"
	var test={
		"name":name,
		"lawOrRef":"law"
	}
	print(var2str(test))

	return test
func load_some_data():
	var test = EZStorage.fetch("test","test")
	print(var2str(test))
	print(test.name)
