extends Control
class_name MoneyDisplayer

@onready var money_number = %MoneyNumber

func set_money(amount:int):
	money_number.text = str(amount) 
