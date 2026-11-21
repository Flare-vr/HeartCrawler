extends Control
@onready var timer: Timer = $Timer
@onready var playerActionTimer: AnimatedSprite2D = $PlayerActionTimer
@onready var energyCount: Label = $PlayerActionTimer/EnergyCount
@onready var playerCharacter: Node2D = $"../PlayerCharacter"
@onready var infoTab: Label = $InfoTab


@export var moveOptions: attacksResource
var moveList = []

signal enemyEffectingAction

#Ready Function
func _ready() -> void:
	var buttonList = [$TabCon/Attacks/VB/HB1/Button1,$TabCon/Attacks/VB/HB1/Button2,$TabCon/Attacks/VB/HB1/Button3,$TabCon/Attacks/VB/HB2/Button4,$TabCon/Attacks/VB/HB2/Button5]
	moveList = [moveOptions.attack1, moveOptions.attack2, moveOptions.attack3]
	for i in range(3):
		if (moveList[i].name!=""):
			buttonList[i].text = moveList[i].name+"\n"+str(moveList[i].cost)+" energy"
	for i in range(2):
		buttonList[i+3].disabled = true
	effectEnergy(0)

func addMove(input: Move) -> void:
	if moveList.size()<5:
		moveList.append(input)
		if (moveList[moveList.size()-1].name!=""):
			if moveList.size()==5:
				$TabCon/Attacks/VB/HB2/Button5.text = moveList[moveList.size()-1].name+"\n"+str(moveList[moveList.size()-1].cost)+" energy"
				$TabCon/Attacks/VB/HB2/Button5.disabled = false
			elif moveList.size()==4:
				$TabCon/Attacks/VB/HB2/Button4.text = moveList[moveList.size()-1].name+"\n"+str(moveList[moveList.size()-1].cost)+" energy"
				$TabCon/Attacks/VB/HB2/Button4.disabled = false
			elif moveList.size()==3:
				$TabCon/Attacks/VB/HB1/Button3.text = moveList[moveList.size()-1].name+"\n"+str(moveList[moveList.size()-1].cost)+" energy"
				$TabCon/Attacks/VB/HB1/Button3.disabled = false
			elif moveList.size()==2:
				$TabCon/Attacks/VB/HB1/Button2.text = moveList[moveList.size()-1].name+"\n"+str(moveList[moveList.size()-1].cost)+" energy"
				$TabCon/Attacks/VB/HB1/Button2.disabled = false
			elif moveList.size()==1:
				$TabCon/Attacks/VB/HB1/Button1.text = moveList[moveList.size()-1].name+"\n"+str(moveList[moveList.size()-1].cost)+" energy"
				$TabCon/Attacks/VB/HB1/Button1.disabled = false

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
				if moveTypeList[i].substr(1,2) == "HB":
					playerCharacter.takeDamage(int(moveTypeList[i].substr(3))*-1)
		
		if (enemyEffectingMoves!=""):
			enemyEffectingAction.emit(enemyEffectingMoves, moveList[num].range)

func updateMoveInfo(num: int):
	infoTab.text = moveList[num].description


func onButton1Pressed() -> void:
	modeProcess(0)

func onButton1MouseOver() -> void:
	if !$TabCon/Attacks/VB/HB1/Button1.disabled:
		updateMoveInfo(0)

func onButton2Pressed() -> void:
	modeProcess(1)

func onButton2MouseOver() -> void:
	if !$TabCon/Attacks/VB/HB1/Button2.disabled:
		updateMoveInfo(1)

func onButton3Pressed() -> void:
	modeProcess(2)

func onButton3MouseOver() -> void:
	if !$TabCon/Attacks/VB/HB1/Button3.disabled:
		updateMoveInfo(2)

func onButton4Pressed() -> void:
	modeProcess(3)

func onButton4MouseOver() -> void:
	if !$TabCon/Attacks/VB/HB2/Button4.disabled:
		updateMoveInfo(3)

func onButton5Pressed() -> void:
	modeProcess(4)

func onButton5MouseOver() -> void:
	if !$TabCon/Attacks/VB/HB2/Button5.disabled:
		updateMoveInfo(4)

func onButtonMouseLeave() -> void:
	infoTab.text = ""



#Enemy Attacking Functions 
func _on_enemy_control_node_player_effecting_move(playerEffectingList) -> void:
	var effectList = playerEffectingList.split(',')
	
	for i in range(effectList.size()):
		if effectList[i].substr(1,2) == "DM":
			playerCharacter.takeDamage(int(effectList[i].substr(3)))
