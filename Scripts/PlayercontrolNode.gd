extends Control
@onready var timer: Timer = $Timer
@onready var playerActionTimer: AnimatedSprite2D = $PlayerActionTimer
@onready var energyCount: Label = $PlayerActionTimer/EnergyCount
@onready var playerCharacter: Node2D = $"../PlayerCharacter"
@onready var moveInformation: Label = $"Move Information"

@export var moveOptions: attacksResource
var moveList = []

signal enemyEffectingAction

#Ready Function
func _ready() -> void:
	var buttonList = [$Button1,$Button2,$Button3,$Button4]
	moveList = [moveOptions.attack1, moveOptions.attack2, moveOptions.attack3, moveOptions.attack4]
	for i in range(4):
		if (moveList[i].name!=""):
			buttonList[i].text = moveList[i].name+" "+str(moveList[i].cost)+"e"
	effectEnergy(0)

#Energy Based Functions
func _on_Energy_timer_timeout() -> void:
	effectEnergy(1)

func effectEnergy(num):
	playerCharacter.stats.currentEnergy += num
	energyCount.text = str(playerCharacter.stats.currentEnergy)
	if playerCharacter.stats.currentEnergy < playerCharacter.stats.maxEnergy and timer.is_stopped():
		timer.start(4)
		playerActionTimer.speed_scale = 1.0
		playerActionTimer.stop()
		playerActionTimer.play()

#Player Attacking Functions
func modeProcess(num: int):
	if playerCharacter.stats.currentEnergy >= moveList[num].cost:
		effectEnergy(moveList[num].cost*-1)
		var moveTypeList = moveList[num].actionCode.split(",",true, 0)
		var enemyEffectingMoves = ""
		
		print(moveTypeList)
		for i in range(moveTypeList.size()):
			if moveTypeList[i].substr(0,1) == "E":
				if i>0:
					enemyEffectingMoves += "," + moveTypeList[i]
				else:
					enemyEffectingMoves += moveTypeList[i]
			elif moveTypeList[i].substr(0,1) == "P":
				if moveTypeList[i].substr(1,2) == "BK":
					playerCharacter.setIsBlocking(int(moveTypeList[i].substr(3)))
				if moveTypeList[i].substr(1,2) == "DM":
					playerCharacter.takeDamage(int(moveTypeList[i].substr(3)))
				if moveTypeList[i].substr(1,2) == "HL":
					playerCharacter.takeDamage(int(moveTypeList[i].substr(3))*-1)
		
		if (enemyEffectingMoves!=""):
			enemyEffectingAction.emit(enemyEffectingMoves, moveList[num].range)

func updateMoveInfo(num: int):
	var deInfo: String = ""
	var gpInfo: String = ""
	var moveTypeList = moveList[num].actionCode.split(",",true, 0)
	for i in range(moveTypeList.size()):
		if moveTypeList[i].substr(1,3) == "DM":
			deInfo = "The character swings their weapon dealing "+moveTypeList[i].substr(3)
			deInfo += " to a target enemy\n"
		elif moveTypeList[i].substr(1,3) == "GP":
			gpInfo = "The character puts up a protective barrior preventing damage for "
			gpInfo += str(float(moveTypeList[i].substr(3))/2)
			gpInfo += " second" + ("s" if float(moveTypeList[i].substr(3))/2 != 1 else "")
	
	moveInformation.text = deInfo +gpInfo 


func onButton1Pressed() -> void:
	modeProcess(0)

func onButton1MouseOver() -> void:
	updateMoveInfo(0)

func onButton2Pressed() -> void:
	modeProcess(1)

func onButton2MouseOver() -> void:
	updateMoveInfo(1)

func onButton3Pressed() -> void:
	modeProcess(2)

func onButton3MouseOver() -> void:
	updateMoveInfo(2)

func onButton4Pressed() -> void:
	modeProcess(3)

func onButton4MouseOver() -> void:
	updateMoveInfo(3)

func onButtonMouseLeave() -> void:
	moveInformation.text = ""



#Enemy Attacking Functions 
func _on_enemy_control_node_player_effecting_move(playerEffectingList) -> void:
	var effectList = playerEffectingList.split(',')
	
	for i in range(effectList.size()):
		if effectList[i].substr(1,2) == "DM":
			playerCharacter.takeDamage(int(effectList[i].substr(3)))
