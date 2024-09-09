extends Area2D

var travelled_distance := 0

# A chaque frame
func _physics_process(delta):
	const SPEED := 700
	const RANGE := 1000
	
	var direction := Vector2.RIGHT.rotated(rotation)
	
	# la balle se déplace
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	
	# si a parcouru la distance RANGE -> destruction
	if travelled_distance > RANGE :
		queue_free()


# fonction au contact d'un body
#Paramètres : body (scene)
#Retour : rien
#
func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"): 
		body.take_damage()
