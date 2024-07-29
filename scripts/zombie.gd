extends CharacterBody2D

# reference au mobspawner
@onready var mob_spawner = get_node("/root/Game/MobSpawner")
# reference au joueur
@onready var player = get_node("/root/Game/Player")
# référence à l'animationdu personnage
@onready var AnimatedSprite = $AnimatedSprite2D
# orientation de base du personnage
@onready var character_orientantion = "front"
# référence au navigation_agent
@onready var navigation_agent = $NavigationAgent2D
# pv
var health = 3
# speed
var movement_speed = 100.0
# type d'animation
@onready var type_of_animation = "idle"
# ennemy en vie
@onready var is_alive := true

# cible de l'agent
@export var target: Node2D = null

func _ready():
	call_deferred("seeker_setup")
	target = get_node("/root/Game/Player")

# fonctions de mise en place du navmesh
#Paramètres : aucun
#Retour : aucun
#
func seeker_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent.target_position = target.global_position

func _physics_process(_delta):
	if is_alive:
		if target:
			navigation_agent.target_position = target.global_position
		if navigation_agent.is_navigation_finished():	
			type_of_animation = "attack"
			# génère une erreur et le jeu fonctionne sans problème sans ça, à voir
			#await 2
		else :
			var current_agent_position = global_position
			var next_path_position = navigation_agent.get_next_path_position()
			velocity = current_agent_position.direction_to(next_path_position) * movement_speed
			type_of_animation = "walking"
			if abs(velocity.x) > abs(velocity.y):
				if velocity.x > 0:
					character_orientantion = "right"
				else:
					character_orientantion = "left"
			else : 
				if velocity.y > 0:
					character_orientantion = "down"
				else:
					character_orientantion = "up"
			move_and_slide()
			
		
		play_animation(character_orientantion, type_of_animation)
	
# fonctions des dégâts subit
#Paramètres : aucun
#Retour : aucun
#
func take_damage():
	if health > 0:
		health -= 1
		if health == 0:
			is_alive = false
			play_animation(character_orientantion, "death")
			await get_tree().create_timer(1.0).timeout
			queue_free()
			mob_spawner.one_mob_dead()

# fonctions faisant les dégâts aux joueurs
#Paramètres : aucun
#Retour : aucun
#
# Déclenche la fonction de dégâts du joueur à la find e l'animation d'attaque.
func deal_damage_to_target():
	print(navigation_agent.distance_to_target())
	if navigation_agent.distance_to_target() < 50:
		target.player_take_damage()
		
func _on_animated_sprite_2d_animation_finished():
	print("ok")
	if type_of_animation == "attack":
		deal_damage_to_target()

# fonction jouant l'animation
#Paramètres : l'orientation du personnage (string), type d'animation (string)
#Retour : rien
#
# En fonction du tpye d'action, puis de l'orientation du personnage
# on joue l'animation adéquate.
func play_animation(orientation, type):
	if type == "walking":
		if orientation == "left":
			AnimatedSprite.play("WalkingLeft")
		if orientation == "right":
			AnimatedSprite.play("WalkingRight")
		if orientation == "up":
			AnimatedSprite.play("WalkingBack")
		if orientation == "down":
			AnimatedSprite.play("WalkingFront")
	if type == "attack":
		if orientation == "left":
			AnimatedSprite.play("AttackingLeft")
		if orientation == "right":
			AnimatedSprite.play("AttackingRight")
		if orientation == "up":
			AnimatedSprite.play("AttackingBack")
		if orientation == "down":
			AnimatedSprite.play("AttackingFront")
	if type == "death":
		if orientation == "left":
			AnimatedSprite.play("DeathLeft")
		if orientation == "right":
			AnimatedSprite.play("DeathRight")
		if orientation == "up":
			AnimatedSprite.play("DeathBack")
		if orientation == "down":
			AnimatedSprite.play("DeathFront")



