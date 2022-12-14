extends Control

onready var dataCreator = preload("res://Control.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var contentWindow = $ContentWindow
onready var Topbar = $Topbar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CreateDataset_pressed():
	var instance =dataCreator.instance()
	instance.connect("setupComplete",self,"_setupCreateComplete")
	contentWindow.add_child(instance)
	
func _setupCreateComplete():
	pass
	
