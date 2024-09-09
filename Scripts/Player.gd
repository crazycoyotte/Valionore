extends CharacterBody2D
@onready var class_manager = $ClassManager
@onready var game := $"../"
@onready var life : int = game.player_parameters.player_actual_life
@onready var life_max : int = game.player_parameters.player_max_life
var last_mouse_position_vector := Vector2(0,0)
@onready var life_bar_max := $LifeBarMax
@onready var life_bar_actual := $LifeBarActual
@onready var pause_menu = $Pause
var paused = false
var animation_type : String = ""

# fonction update
func _physics_process(_delta):
	
	# MAJ de la lifeBar
	life_bar_max.play(str(life_max))
	life_bar_actual.play(str(life))
	
	# si le joueur se déplace
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2(0,0):
		MovePlayer(direction)
		
	else :
		velocity = Vector2(0,0)
		animation_type = "Idle"
	
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		

# fonction déplaçant le personnage
#Paramètres : direction (vector2)
#Retour : rien
#
func MovePlayer(direction):
	velocity = direction * 100
	animation_type = "WalkingRight"
	move_and_slide()
	
	


# fonction faisant perdre un pv au joueur
#Paramètres : aucun
#Retour : rien
#
func player_take_damage():
	life -= 1
	print(life)
	if life < 1:
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")


# fonction mettant le jeu en pause
#Paramètres : aucun
#Retour : rien
#
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
