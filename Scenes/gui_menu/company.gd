extends Control

@onready var capital_label: Label = $capital_label
@onready var date_label: Label = $date_label

func _ready():
	# Connexion au signal de GameLogic
	GameLogic.connect("month_passed", Callable(self, "_on_month_passed"))

	# Affichage initial
	_update_labels()
	
func _process(_delta):
	_update_labels()  # Mise à jour continue
	
func _on_month_passed():
	_update_labels()

func _update_labels():
	capital_label.text = "Capital: %d" % GameLogic.capital
	date_label.text = "Date: Mois %d, Année %d" % [GameLogic.current_month, GameLogic.current_year]
