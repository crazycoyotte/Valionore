extends Area2D

func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
# fonction de tir
#Paramètres : aucun
#Retour : rien
#
#création d'un objet bullet
func shoot():
	const BULLET = preload("res://Scenes/Bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
