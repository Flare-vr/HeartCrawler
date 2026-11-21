extends Resource
class_name ItemResource

@export var name: String
@export_enum("Just like you", "Simple", "Valueble", "Gorgeous", "Nothing like you") var rarity: String
@export_enum("Weapon", "AxNeck", "AxHand", "AxWaist", "AxFoot", "Consumable") var itemType: String
@export_enum("noble", "gifted", "vital", "accused", "nobody","none") var itemClass: String
@export var move1: Move
@export var move2: Move
@export_multiline() var description: String
