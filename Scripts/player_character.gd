extends Node2D
@onready var progressBar: TextureProgressBar = $TextureProgressBar
@onready var blockingResetTimer: Timer = $BlockingResetTimer
@onready var blockingIcon: Sprite2D = $BlockingIcon
var isBlocking = false

@export var stats: CharacterResource

@onready var bloodStress: int = stats.maxBloodStress
var bloodProtection: int = 0
@onready var brainStress: int = stats.maxBrainStress
@onready var beatStress: int = stats.maxBeatStress

var headArmor: ItemResource
var bodyArmor: ItemResource
var weapon: ItemResource
var accessoryList: Array
var Inventory: Array



func _ready() -> void:
	progressBar.max_value = stats.maxBloodStress
	progressBar.value = stats.maxBloodStress
	

func changeTickSpeed(Mod):
	pass

func takeDamage(num:int):
	if !isBlocking:
		if bloodProtection> 0:
			bloodProtection-=num
			if bloodProtection< 0:
				bloodProtection = 0
		else:
			bloodStress -=num
			if bloodStress > stats.maxBloodStress:
				bloodStress = stats.maxBloodStress
			progressBar.value = bloodStress

func setIsBlocking(frames: int):
	isBlocking = true
	blockingResetTimer.start(frames/2)
	blockingIcon.visible = true

func _on_blocking_reset_timer_timeout() -> void:
	isBlocking = false
	blockingIcon.visible = false
