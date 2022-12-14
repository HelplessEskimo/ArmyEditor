extends Control

onready var defines = preload("res://defines.gd")
onready var uuidGen = preload("res://uuid.gd")
onready var tree = $ContentWindow/Tree
onready var lawOrRef = $ContentWindow/Panel/LawOrReference
onready var unique = $ContentWindow/Panel/Unique
onready var type = $ContentWindow/Panel/Type
onready var nameOf = $ContentWindow/Panel/Name
onready var root = tree.create_item()
var data
var activeItem
var activeTreeItem 
func _ready():
	tree.set_hide_root(false)
	activeTreeItem = root
	root.set_metadata(0,"root")
	_load_data("data")
	fillTree()
func _load_data(dir):
	data = EZCache.get_section(dir)


func fillTree():
	var uuids = data.fetch("UUIDS")
	for i in uuids:
		var datapoint = data.fetch(i)
		var child = tree.create_item(root)
		child.set_text(0,datapoint.name)
		child.set_metadata(0,datapoint.UUID)
		if datapoint.dataPoints !=[]:
			fillSubTree(datapoint,child)
func fillSubTree(dataPoint,Parent):
	for i in dataPoint.dataPoints:
		var datapoint = data.fetch(i)
		var child = tree.create_item(Parent)
		child.set_text(0,datapoint.name)
		child.set_metadata(0,datapoint.UUID)
		if datapoint.dataPoints !=[]:
			fillSubTree(datapoint,child)


func _on_Tree_item_selected():
	if tree.get_selected().get_metadata(0) == "root":
		return
	if tree.get_selected().get_metadata(0) != null:
		_load_editPanel(tree.get_selected().get_metadata(0))
		activeTreeItem = tree.get_selected()
func _load_editPanel(uuid):
	var datapoint = data.fetch(uuid);
	lawOrRef.selected = datapoint.lawOrRef
	unique.selected = datapoint.unique
	type.selected = datapoint.type
	nameOf.text = datapoint.name
	


func _on_AddItem_pressed():
	var datapoint = data.fetch(activeTreeItem.get_metadata(0))
	if datapoint != null:
		if datapoint.type == 2||datapoint.type == 3:
			return  #need to give error message
	var child = tree.create_item(activeTreeItem)
	child.set_text(0,"Name of Item")
	activeTreeItem = child
	_on_Save_pressed()
	

func _on_RemoveItem_pressed():
	pass # Replace with function body.

func _save_datapoint():
	pass
	
func _on_Save_pressed():
	var temp = null

	var datapoint = {
		"lawOrRef":lawOrRef.selected,
		"unique":unique.selected,
		"type":type.selected,
		"name":nameOf.text,
		"UUID" 		: uuidGen.v4(),
		"dataPoints": []
	}
	if activeTreeItem.get_metadata(0)!=null:
		temp = data.fetch(activeTreeItem.get_metadata(0))
		datapoint.UUID = temp.UUID
		datapoint.dataPoints = temp.dataPoints
	data.store(datapoint.UUID,datapoint)
	if activeTreeItem.get_metadata(0)==null:
		activeTreeItem.set_metadata(0,datapoint.UUID)
		
	if activeTreeItem.get_parent() == root:
		var uuids = data.fetch("UUIDS")
		uuids.append(datapoint.UUID)
		data.store("UUIDS",uuids)
	activeTreeItem.set_text(0,nameOf.text)
		 

