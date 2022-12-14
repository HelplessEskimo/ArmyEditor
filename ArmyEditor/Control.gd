extends Control


signal setupComplete

onready var defines = preload("res://defines.gd")
onready var itemBox = preload("res://ItemOfClass.tscn")
onready var uuidGen = preload("res://uuid.gd")
var classes = []
var data = EZCache.get_section("data")
var uuids = []
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
			data.store(dataPoint.UUID,dataPoint)
			var temp = data.fetch(classes[0].UUID)
			temp.dataPoints.append(dataPoint.UUID)
			data.purge_key(classes[0].UUID)
			data.store(classes[0].UUID,temp)
			print(temp)
		classes.erase(classes[0])
	else:
		for i in vBox.get_children():
			var dataPoint = getDatapoint(i)
			uuids.append(dataPoint.UUID)
			data.store(dataPoint.UUID,dataPoint)
	#check if there are classes that need resolving
	for i in vBox.get_children():
		vBox.remove_child(i)
	if classes != []:
		panelName.text = classes[0].name
	if classes == []:
		data.store("UUIDS",uuids)
		#this should only be reachable after everything is filled
		pass

func getDatapoint(i):# i is a child of type ItemOfClass (itemBox)
	var dataPoint = {
		"lawOrRef" 	: i.get_child(0).get_child(0).selected,
		"type"		: i.get_child(0).get_child(1).selected,
		"unique" 	: i.get_child(0).get_child(2).selected,
		"name" 		: i.get_child(0).get_child(3).text,
		"UUID" 		: uuidGen.v4(),
		"dataPoints": []
	}
	if i.get_child(0).get_child(1).text == "Class":
		classes.append(dataPoint)
	return dataPoint
func _on_ButtonAddItem_pressed():
	vBox.add_child(itemBox.instance(),true)


