extends CharacterBody2D
@onready var animated_sprite := $AnimatedSprite2D
@onready var weapon := $Weapon
@onready var weapon_sprite := $Weapon/Weapon_pivot/Shotgun
var life := 3
var life_max := 3
var last_mouse_position_vector := Vector2(0,0)
@onready var life_bar_max := $LifeBarMax
@onready var life_bar_actual := $LifeBarActual

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
	
	# si le joueur vise
	var look_direction := Vector2(0,0)
	var actual_mouse_position_vector := get_global_mouse_position() - global_position
	actual_mouse_position_vector.x = int(actual_mouse_position_vector.x)
	actual_mouse_position_vector.y = int(actual_mouse_position_vector.y)
	
	if (abs(actual_mouse_position_vector.x - last_mouse_position_vector.x)) > 2 or (abs(actual_mouse_position_vector.y - last_mouse_position_vector.y) > 2):
		look_direction = actual_mouse_position_vector
		print (actual_mouse_position_vector)
	else :
		look_direction = Input.get_vector("look_left","look_right","look_up","look_down")
	if look_direction != Vector2(0,0):
		OrientateWeapon(look_direction)
	
	# animation du joueur
	if (velocity.x == 0) and (velocity.y == 0) :
		get_node("AnimatedSprite2D").play("Idle")
	else :
		get_node("AnimatedSprite2D").play("WalkingRight")
		
	last_mouse_position_vector = actual_mouse_position_vector
	
		
func MovePlayer(direction):
	velocity = direction * 100
	move_and_slide()
	
	
# fonction orientant l'arme dans la direction pointée
#Paramètres : look_direction (vector2)
#Retour : rien
#
func OrientateWeapon(look_direction):
	weapon.global_rotation = look_direction.angle()
	if (look_direction.angle() > PI/2) or (look_direction.angle() < -PI/2):
		weapon_sprite.flip_v = true
		animated_sprite.flip_h = true
	else : 
		weapon_sprite.flip_v = false
		animated_sprite.flip_h = false

# fonction faisant perdre un pv au joueur
#Paramètres : aucun
#Retour : rien
#
func player_take_damage():
	life -= 1
	print(life)
	if life < 1:
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

