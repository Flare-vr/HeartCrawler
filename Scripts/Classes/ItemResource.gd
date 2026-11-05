extends Resource
class_name ItemResource

@export var name: String
@export_enum("Armor", "Weapon", "Accsessory", "Consumable") var itemType: String
@export_enum("noble", "gifted", "accused", "famous", "prodigy") var itemClass1: String
@export_enum("noble", "gifted", "accused", "famous", "prodigy", "none") var itemClass2: String = "none"
@export var move1: Move
@export var move2: Move
@export_multiline() var description: String
