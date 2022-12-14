extends Control
onready var defines = preload("res://defines.gd")
onready var tree = $Tree
onready var root = tree.create_item()
var data = EZCache.get_section("data")
# Called when the node enters the scene tree for the first time.
func _ready():
	tree.set_hide_root(true)
	fillTree()
	pass # Replace with function body.

func fillTree():
	var uuids = data.fetch("UUIDS")
	for i in uuids:
		var datapoint = data.fetch(i)
		var child = tree.create_item(root)
		child.set_text(0,datapoint.name)
		if datapoint.dataPoints !=[]:
			fillSubTree(datapoint,child)
func fillSubTree(dataPoint,Parent):
	for i in dataPoint.dataPoints:
		var datapoint = data.fetch(i)
		var child = tree.create_item(Parent)
		child.set_text(0,datapoint.name)
		if datapoint.dataPoints !=[]:
			fillSubTree(datapoint,child)
