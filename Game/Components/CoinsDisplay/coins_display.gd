extends Label

@export var coins : int = 0

func _ready() -> void:
	update_display()

func update_display():
	coins = SaveLoad.SaveFileData.coins
	text = str(coins) + " Coins"
