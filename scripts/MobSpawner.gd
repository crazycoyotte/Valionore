extends Node2D

@onready var mobs_to_spawn = 1
@onready var mobs_alive = 1
@onready var map = get_node(("/root/Game/level0/"))
@onready var map_spawn_areas = map.get_child(0)
@onready var ennemy = preload("res://scenes/zombie.tscn")
var spawn_areas = []
var last_spawn_area

func _ready():
	for i in map_spawn_areas.get_children():
		if i is ReferenceRect:
			spawn_areas.append(i)
	last_spawn_area = spawn_areas[randi() % spawn_areas.size()]

func _physics_process(delta):
	if mobs_alive == 0:
		mobs_to_spawn += 1
		SpawnMob()
		print(mobs_to_spawn)

# fonction faisant apparaitre un mob dans une des zones de spawns à une position aléatoire
#Paramètres : aucun
#Retour : rien
#
func SpawnMob():
	var i = 0
	while i < mobs_to_spawn:
		var spawn_area = spawn_areas[randi() % spawn_areas.size()]
		if spawn_area.name != last_spawn_area.name:
			var spawn_position = spawn_area.position + Vector2(randf() * spawn_area.size.x, randf() * spawn_area.size.y)
			var ennemy_instance = ennemy.instantiate()
			ennemy_instance.position = spawn_position
			add_child(ennemy_instance)
			i += 1
			mobs_alive += 1
		

# fonction diminuant le nombre de mob actif de 1
#Paramètres : aucun
#Retour : rien
#
func one_mob_dead():
	mobs_alive -= 1
