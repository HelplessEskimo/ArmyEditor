extends Control
class Datapoint:
	var lawOrRef = ""
	var type = ""
	var unique = ""
	var name = ""
onready var itemBox = preload("res://ItemOfClass.tscn")
var classes = []
var data = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var vBox = $Panel/VBoxContainer
onready var panelName = $Panel/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):


func _on_ButtonNext_pressed():
	#read data from Vbox
	if classes != []:
		var dataClass = []
		var name = classes[0].name
		dataClass.append(name)
		for i in vBox.get_children():
			var dataPoint = getDatapoint(i)
			dataClass.append(dataPoint)
		data.append(dataClass)
		classes.erase(classes[0])
	else:
		for i in vBox.get_children():
			var dataPoint = getDatapoint(i)
			data.append(dataPoint)
	#check if there are classes that need resolving
	if classes != []:
		for i in vBox.get_children():
			vBox.remove_child(i)
		panelName.text = classes[0].name
						
		#load new input fields
		#and save those inputs here
		#can be done recursive(but not with scene)

	#save data in json file

	
	if classes == []:
		var file = File.new()
		file.open("user://save_srtuct.dat", File.WRITE)
		file.store_line(to_json(var2str(data)))
		file.close()
		#done with this part
	pass # Replace with function body.
func getDatapoint(i):
	var dataPoint = Datapoint.new()
	dataPoint.lawOrRef = i.get_child(0).get_child(0).text
	dataPoint.type = i.get_child(0).get_child(1).text
	dataPoint.unique = i.get_child(0).get_child(2).text
	dataPoint.name = i.get_child(0).get_child(3).text
	
	if i.get_child(0).get_child(1).text == "Class":
		classes.append(dataPoint)
	return dataPoint
func _on_ButtonAddItem_pressed():
	vBox.add_child(itemBox.instance(),true)
