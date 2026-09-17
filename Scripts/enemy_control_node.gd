extends Node2D
var enemyNum = 3
var moveCode: String = ""
var moveRange: Vector2i = Vector2i(-1,-1)
signal playerEffectingMove
var enemyPositionList = []

#Ready Function
func _ready() -> void:
	
	for i in range(get_child_count()):
		get_child(i).enemyPosition = i
		enemyPositionList.append(i)


#Utility Functions
func disableEnemyButtons(isEnabled):
	if enemyNum<moveRange[1]:
		for e in range(moveRange[0], enemyNum):
			getEnemy(e).disabled = isEnabled
	else:
		for e in range(moveRange[0], moveRange[1]):
			getEnemy(e).disabled = isEnabled

func getEnemy(num: int):
	for i in range(get_child_count()):
		if get_child(i).enemyPosition == num:
			return get_child(i)

func updateEnemyPositions(type: String, enemyPos: int, shift: int):
	var tween1 = create_tween()
	var tween2 = create_tween()
	var enemyPrev = -1
	var tempEnemyArr = []
	
	for i in range(enemyPos, enemyPos+shift+1):
		tempEnemyArr.append(getEnemy(i))
	
	tween1.set_trans(Tween.TRANS_CIRC)
	tween1.tween_property(tempEnemyArr[0], "position:x", tempEnemyArr[0].position.x+(75*shift), .5)
	tween2.set_ease(Tween.EASE_OUT)
	tween2.set_trans(Tween.TRANS_QUAD)
	tween2.tween_property(tempEnemyArr[0], "position:y", -130, .15)
	tween2.set_trans(Tween.TRANS_BOUNCE)
	tween2.chain().tween_property(tempEnemyArr[0], "position:y", -115, .35)
	tempEnemyArr[0].enemyPosition += shift
	
	for i in range(1, shift+1):
		var tween3 = create_tween()
		tween3.set_trans(Tween.TRANS_BACK)
		tween3.tween_property(tempEnemyArr[i], "position:x", tempEnemyArr[i].position.x, .15)
		tween3.tween_property(tempEnemyArr[i], "position:x", tempEnemyArr[i].position.x-(75*i), .5)
		tempEnemyArr[i].enemyPosition -= shift
	
	for i in range(get_child_count()):
		enemyPositionList[i] = get_child(i).enemyPosition

#Player Attacking Functions
func _on_attack_button_enemy_effecting_action(effectTypes:String,effectRange:Vector2i) -> void:
	moveCode = effectTypes
	moveRange = effectRange
	disableEnemyButtons(false)

func moveProcess(num: int):
	if moveCode == "":
		pass
	var codeList = moveCode.split(',')
	
	
	for i in range(codeList.size()):
		if codeList[i].substr(1,2) == "DM":
			getEnemy(num).takeDamage(int(codeList[i].substr(3)))
		if codeList[i].substr(1,2) == "AD":
			for j in range(moveRange[0], (enemyNum if moveRange[1]>enemyNum else moveRange[1])):
				getEnemy(j).takeDamage(int(codeList[i].substr(3)))
		if codeList[i].substr(1,2) == "PS":
			print("working")
			updateEnemyPositions("shift", num, int(codeList[i].substr(3)))
		
	
	disableEnemyButtons(true)
	
	moveCode = ""
	moveRange = Vector2i(-1,-1)
	


func enemyCharacter1Pressed() -> void:
	moveProcess(enemyPositionList[0])


func enemyCharacter2Pressed() -> void:
	moveProcess(enemyPositionList[1])


func enemyCharacter3Pressed() -> void:
	moveProcess(enemyPositionList[2])


##Enemy Attacking Fuctions
func _on_enemy_character_enemy_attack(attackType: String, enemyNum: int) -> void:
	var codeList = attackType.split(",")
	var playerEffectingList = ""
	
	for i in range(codeList.size()):
		if codeList[i].substr(0,1) == "P":
			if i>0:
				playerEffectingList += "," + codeList[i]
			else:
				playerEffectingList += codeList[i]
		elif codeList[i].substr(0,1) == "E":
			if codeList[i].substr(1,2) == "DM":
				getEnemy(enemyNum).takeDamage(int(codeList[i].substr(3)))
	
	if (playerEffectingList!=""):
		playerEffectingMove.emit(playerEffectingList)
