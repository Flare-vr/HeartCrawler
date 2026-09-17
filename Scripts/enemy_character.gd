extends Button
@onready var progressBar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer
@onready var enemyTimer: AnimatedSprite2D = $EnemyTimer

@export var enemyStats: CharacterResource
@export var options: attacksResource
var enemyAttackList = []
var currentInPattern = 0
var enemyPosition:int = 0

signal enemyPressed
signal enemyAttack

var attackerIntentions = "unknown"

func _ready() -> void:
	progressBar.max_value = enemyStats.maxHealth
	progressBar.value = enemyStats.maxHealth
	enemyAttackList = [options.attack1, options.attack2, options.attack3, options.attack4]
	resetTimer()
	

func resetTimer():
	timer.start(enemyAttackList[options.attackPattern[currentInPattern]].cost*4)
	enemyTimer.speed_scale = 1.0/enemyAttackList[options.attackPattern[currentInPattern]].cost
	enemyTimer.stop()
	enemyTimer.play("default")



func _on_timer_timeout() -> void:
	enemyAttack.emit(enemyAttackList[options.attackPattern[currentInPattern]].actionCode, enemyPosition)
	currentInPattern+= 1
	if currentInPattern >= options.attackPattern.size():
		currentInPattern = 0
	resetTimer()



func takeDamage(damage):
	enemyStats.currentHealth -= damage
	progressBar.value = enemyStats.currentHealth
	if enemyStats.currentHealth <= 0:
		die()

func die():
	queue_free()
