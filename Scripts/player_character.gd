extends Node2D
@onready var progressBar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer

@export var charStats: CharacterResource

func _ready() -> void:
	progressBar.max_value = charStats.maxHealth
	progressBar.value = charStats.maxHealth
	

func changeHealth(Difference:int):
	charStats.currentHealth +=Difference
	if charStats.currentHealth > charStats.maxHealth:
		charStats.currentHealth = charStats.maxHealth
	progressBar.value = charStats.currentHealth
	

func _on_timer_timeout() -> void:
	charStats.currentEnergy+=1
	if charStats.currentEnergy < charStats.maxEnergy:
		timer.start()
	

func changeTickSpeed(Mod):
	pass
