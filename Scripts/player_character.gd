extends Node2D
@onready var progressBar: TextureProgressBar = $TextureProgressBar
@onready var blockingResetTimer: Timer = $BlockingResetTimer
@onready var blockingIcon: Sprite2D = $BlockingIcon
var isBlocking = false

@export var stats: CharacterResource

func _ready() -> void:
	progressBar.max_value = stats.maxHealth
	progressBar.value = stats.maxHealth
	

func changeHealth(Difference:int):
	stats.currentHealth +=Difference
	if stats.currentHealth > stats.maxHealth:
		stats.currentHealth = stats.maxHealth
	progressBar.value = stats.currentHealth
	


func changeTickSpeed(Mod):
	pass


func takeDamage(num:int):
	if !isBlocking:
		stats.currentHealth -=num
		progressBar.value = stats.currentHealth

func setIsBlocking(frames: int):
	isBlocking = true
	blockingResetTimer.start(frames/2)
	blockingIcon.visible = true

func _on_blocking_reset_timer_timeout() -> void:
	isBlocking = false
	blockingIcon.visible = false
