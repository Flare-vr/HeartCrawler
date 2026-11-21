extends TabBar
@onready var equipButton: Button = $HB/VBox/EquipButton
@onready var discardButton: Button = $HB/VBox/DiscardButton
@onready var giveButton: Button = $HB/VBox/GiveButton
@onready var itemList: ItemList = $HB/ItemList
@onready var characterTab: TabBar = $"../Character"

var inventoryArr:Array
var inventoryMaxSize:int = 10;

func onItemSelected(index: int) -> void:
	equipButton.disabled = false
	discardButton.disabled = false
	giveButton.disabled = false

func _ready() -> void:
	addItem(load("res://Objects/Items/SilverSword.tres"))


func addItem(input:ItemResource):
	if inventoryArr.size() < inventoryMaxSize:
		inventoryArr.append(input)
		itemList.add_item(input.name)

func discardItemPressed() -> void:
	if itemList.is_anything_selected():
		var index: int
		var pop: ItemResource
		for i in range(inventoryArr.size()):
			if itemList.is_selected(i):
				index = i
				break
		for i in range(inventoryArr.size()):
			if inventoryArr[i].name == itemList.get_item_text(index):
				pop = inventoryArr[i]
				inventoryArr.remove_at(i)
				break
		itemList.remove_item(itemList.get_selected_items()[0])
	equipButton.disabled = true
	discardButton.disabled = true
	giveButton.disabled = true


func _on_equip_button_pressed() -> void:
	if itemList.is_anything_selected():
		var index: int
		var itemI: int
		for i in range(inventoryArr.size()):
			if itemList.is_selected(i):
				index = i
		for i in range(inventoryArr.size()):
			if inventoryArr[i].name == itemList.get_item_text(index):
				itemI = i
		if characterTab.equipItem(inventoryArr[itemI]):
			discardItemPressed()
		else:
			print("Item Already Equiped")
	equipButton.disabled = true
	discardButton.disabled = true
	giveButton.disabled = true

#func convertItem (input:ItemResource) -> Dictionary:
	#var output = {
		#"name" : input.name,
		#"type" : input.itemType,
		#"class" : input.itemClass,
		#"move1" : input.move1,
		#"move2" : input.move2,
		#"des" : input.description
	#}
	#return output
#
#func revertItem (input:Dictionary) -> ItemResource:
	#var output = ItemResource
	#output.name = input["name"]
	#output.itemType = input["type"]
	#output.itemClass = input["class"]
	#output.move1 = input["move1"]
	#output.move2 = input["move2"]
	#output.description = input["des"]
	#return output
