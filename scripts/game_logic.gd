extends Node

var capital: int = 10000
var monthly_cost: int = 500
var current_month: int = 1
var current_year: int = 1900

signal month_passed(month: int, year: int, capital: int)

func next_month():
	current_month += 1
	if current_month > 12:
		current_month = 1
		current_year += 1
	
	capital -= monthly_cost
	emit_signal("month_passed", current_month, current_year, capital)
