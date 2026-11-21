extends TabBar
@onready var control: Control = $"../.."

@onready var weaponSlot: Button = $"Weapon Slot"
@onready var neckSlot: Button = $"Neck Slot"
@onready var handSlot: Button = $"Hand Slot"
@onready var wasteSlot: Button = $"Waste Slot"
@onready var footSlot: Button = $"Foot Slot"

var weapon: ItemResource
var neckAx: ItemResource
var handAx: ItemResource
var wasteAx: ItemResource
var footAx: ItemResource

func equipItem(input: ItemResource) -> bool:
	if input.itemType == "Weapon" and weaponSlot.text == "Weapon: None":
		weapon = input
		weaponSlot.text = "Weapon: "+ weapon.name
		control.addMove(input.move1)
		control.addMove(input.move2)
		return true
	elif input.itemType == "AxNeck" and neckSlot.text == "Necklace: None":
		neckAx = input
		neckSlot.text = "Necklace: "+ neckAx.name
		return true
	elif input.itemType == "AxHand" and handSlot.text == "Ring: None":
		handAx = input
		handSlot.text = "Ring: "+ handAx.name
		return true
	elif input.itemType == "AxWaist" and wasteSlot.text == "Belt: None":
		wasteAx = input
		wasteSlot.text = "Belt: "+ wasteAx.name
		return true
	elif input.itemType == "AxFoot" and footSlot.text == "Boots: None":
		footAx = input
		footSlot.text = "Boots: "+ footAx.name
		return true
	return false
