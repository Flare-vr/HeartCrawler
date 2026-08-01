extends Node2D
@onready var progressBar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer

@export var enemyRes: CharacterResource

func _ready() -> void:
	progressBar.max_value = enemyRes.maxHealth
	progressBar.value = enemyRes.maxHealth
	

func changeHealth(Difference:int):
	enemyRes.currentHealth +=Difference
	if enemyRes.currentHealth > enemyRes.maxHealth:
		enemyRes.currentHealth = enemyRes.maxHealth
	progressBar.value = enemyRes.currentHealth
	




func _on_timer_timeout() -> void:
	enemyRes.currentEnergy+=1
	if enemyRes.currentEnergy < enemyRes.maxEnergy:
		timer.start()
	
