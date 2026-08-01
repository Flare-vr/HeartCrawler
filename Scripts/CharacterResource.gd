extends Resource
class_name CharacterResource

@export var Name: String
@export var spriteFrames:SpriteFrames
var character:Node2D

@export var maxHealth:int = 15
var currentHealth = maxHealth

@export var maxMana:int = 10
var currentMana = maxMana

@export var maxEnergy:int = 2
var currentEnergy = 0

@export var damage: int = 5
