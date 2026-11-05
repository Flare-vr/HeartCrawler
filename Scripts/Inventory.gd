extends TabBar
@onready var equipButton: Button = $HB/VBox/EquipButton
@onready var discardButton: Button = $HB/VBox/DiscardButton
@onready var giveButton: Button = $HB/VBox/GiveButton
@onready var itemList: ItemList = $HB/ItemList
var inventoryArr:Array
var inventorySize:int = 10;

func onItemSelected(index: int) -> void:
	equipButton.disabled = false
	discardButton.disabled = false
	giveButton.disabled = false

func collectItem(name: String):
	if name == "Great Sword":
		return load("res://Objects/Items/GreatSwordObject.tres")

func addItem(input:ItemResource):
	if inventoryArr.size() < inventorySize:
		inventoryArr.append(input)
		itemList.add_item(input.name)

func discardItemPressed() -> void:
	if itemList.is_anything_selected():
		for i in range(inventoryArr.size()):
			if inventoryArr[i].name == itemList.get_selected_items()[0]:
				inventoryArr.remove_at(i)
		itemList.remove_item(itemList.get_selected_items()[0])
	equipButton.disabled = true
	discardButton.disabled = true
	giveButton.disabled = true


func _on_equip_button_pressed() -> void:
	pass # Replace with function body.
