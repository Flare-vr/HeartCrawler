extends Resource
class_name attacksResource

#general format for attack Arrays list["attack name", "DP,DE,BE", 1.6]
#
#Attack Types: 
#DP1: Damage Player *
#DE1: Damage Enemy *
#BP: Bleed Player
#BE: Bleed Enemy
#HP: Haste Player
#HE: Haste Enemy
#SP: Slow Player
#SE: Slow Enemy


@export var attackPattern:Array = [0]
@export var attack1: Move 
@export var attack2: Move 
@export var attack3: Move 
@export var attack4: Move 
