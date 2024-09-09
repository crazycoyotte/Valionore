extends Node2D
@onready var class_manager = $"../"
@onready var weapon_sprite := $Weapon/Weapon_pivot/Shotgun
@onready var animated_sprite := $AnimatedSprite2D
@onready var weapon := $Weapon
var last_mouse_position_vector := Vector2(0,0)

func _physics_process(_delta: float) -> void:
	
	# si le joueur vise
	var look_direction := Vector2(0,0)
	var actual_mouse_position_vector := get_global_mouse_position() - global_position
	actual_mouse_position_vector.x = int(actual_mouse_position_vector.x)
	actual_mouse_position_vector.y = int(actual_mouse_position_vector.y)
	
	if (abs(actual_mouse_position_vector.x - last_mouse_position_vector.x)) > 2 or (abs(actual_mouse_position_vector.y - last_mouse_position_vector.y) > 2):
		look_direction = actual_mouse_position_vector
		
	else :
		look_direction = Input.get_vector("look_left","look_right","look_up","look_down")
	if look_direction != Vector2(0,0):
		OrientateWeapon(look_direction)
	
	last_mouse_position_vector = actual_mouse_position_vector
	
	# animation du joueur
	if class_manager.player.animation_type == "Idle" :
		animated_sprite.play("Idle")
	if class_manager.player.animation_type == "WalkingRight" :
		animated_sprite.play("WalkingRight")
	
# fonction orientant l'arme dans la direction pointée
#Paramètres : look_direction (vector2)
#Retour : rien
#
func OrientateWeapon(look_direction):
	if class_manager.player.paused == false:
		weapon.global_rotation = look_direction.angle()
		if (look_direction.angle() > PI/2) or (look_direction.angle() < -PI/2):
			weapon_sprite.flip_v = true
			animated_sprite.flip_h = true
		else : 
			weapon_sprite.flip_v = false
			animated_sprite.flip_h = false
