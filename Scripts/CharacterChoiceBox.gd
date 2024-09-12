extends VBoxContainer
@onready var game := $"../"
@onready var player_class_label = $"../PlayerClass"

# fonction lors de l'appui sur le bouton harpon
#Paramètres : rien
#Retour : rien
#
func _on_button_harpon_pressed():
	game.player_parameters.player_class = "harpon"
	player_class_label.text = str(game.player_parameters.player_class)


# fonction lors de l'appui sur le bouton épée
#Paramètres : rien
#Retour : rien
#
func _on_button_epee_pressed():
	game.player_parameters.player_class = "epee"
	print(game.player_parameters.player_class)
	player_class_label.text = str(game.player_parameters.player_class)
