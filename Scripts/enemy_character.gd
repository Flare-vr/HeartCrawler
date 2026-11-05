extends Button
@onready var progressBar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer
@onready var enemyTimer: AnimatedSprite2D = $EnemyTimer
@onready var enemySprite: AnimatedSprite2D = $EnemySprite

var enemyStats: EnemyResource

var enemyAttackList = []
var currentInPattern = 0
var enemyPosition:int = 0
var isCorpse:bool

signal enemyPressed
signal enemyAttack
signal enemyDied

var attackerIntentions = "unknown"

func readyEnemy(object, pos) -> void:
	enemyStats = object
	enemyPosition = pos
	isCorpse = enemyStats.isCorpse
	setAnimation(true)
	progressBar.max_value = enemyStats.maxStress
	progressBar.value = enemyStats.maxStress
	enemyAttackList = [enemyStats.movesList.attack1, enemyStats.movesList.attack2, enemyStats.movesList.attack3, enemyStats.movesList.attack4]
	resetTimer()
	

func setAnimation(isAlive: bool):
	if isAlive:
		if isCorpse:
			enemySprite.play(enemyStats.name+"-Corpse")
		else:
			enemySprite.play(enemyStats.name+"-Alive")
	else:
		enemySprite.play("A")

func resetTimer():
	timer.start(enemyAttackList[enemyStats.movePattern[currentInPattern]].cost*4)
	enemyTimer.speed_scale = 1.0/enemyAttackList[enemyStats.movePattern[currentInPattern]].cost
	enemyTimer.stop()
	enemyTimer.play("default")



func _on_timer_timeout() -> void:
	enemyAttack.emit(enemyAttackList[enemyStats.movePattern[currentInPattern]].actionCode, enemyPosition)
	currentInPattern+= 1
	if currentInPattern >= enemyStats.movePattern.size():
		currentInPattern = 0
	resetTimer()


func takeDamage(damage):
	progressBar.value -= damage
	if progressBar.value <= 0:
		die()

func die():
	if isCorpse:
		enemyDied.emit(enemyPosition)
		setAnimation(false)
	else:
		isCorpse = true
		takeDamage(enemyStats.maxStress/-2)
		setAnimation(true)
