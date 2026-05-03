extends RigidBody2D

# variavel que vai guardar os diferentes tipos de velocidade do inimigo
var speed_enemy = 0.0

func _ready():
	var enemy_animations = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var random_index = randi() % enemy_animations.size() 
	$AnimatedSprite2D.play(enemy_animations[random_index])
	
	# variável speed que será definida dentro da função _ready()
	match $AnimatedSprite2D.animation:
		"walk":
			speed_enemy = 90.0
		"swim":
			speed_enemy = 120.0
		"fly":
			speed_enemy = 180.0
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Destruindo inimigo!")
	queue_free()
