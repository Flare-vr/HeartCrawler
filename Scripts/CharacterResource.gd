extends Resource
class_name CharacterResource

@export var Name: String
@export var spriteFrames:SpriteFrames
var character:Node2D
@export var size: int = 1

@export var maxHealth: int = 15
@export var currentHealth: int = 15

@export var maxMana: int = 10
@export var currentMana: int = 10

@export var maxEnergy: int = 4
var currentEnergy: int = 1

@export var damage: int = 5
