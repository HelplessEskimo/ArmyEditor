extends Control

onready var itemBox = preload("res://ItemOfClass.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var vBox = $Panel/VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonNext_pressed():
	
	pass # Replace with function body.


func _on_ButtonAddItem_pressed():
	vBox.add_child(itemBox.instance(),true)
