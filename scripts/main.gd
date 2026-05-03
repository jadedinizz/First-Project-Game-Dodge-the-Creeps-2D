extends Node2D

var score
@export var enemy_scene: PackedScene
@export var bomb_scene: PackedScene
@export var chaser_scene: PackedScene
@export var item_scene: PackedScene

func _ready():
	pass
	
func start_game():
	score = 0
	$HUD.update_score(score)
	get_tree().call_group("enemy", "queue_free")
	$ScoreTimer.start()
	$EnemyTimer.start()
	$ChaserTimer.start()
	$BombTimer.start()   
	$ItemTimer.start()
	$Player.start($StartPosition.position)
	$BackMusic.play()
	
func game_over():
	$Player.hide()
	$EnemyTimer.stop()
	$ChaserTimer.stop()
	$BombTimer.stop()   
	$ItemTimer.stop()
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$BackMusic.stop()
	$DeathSound.play()
	
func _on_enemy_timer_timeout() -> void:
	var new_enemy = enemy_scene.instantiate()
	
	add_child(new_enemy)
	# definir posiçao
	var path_follow_2d = $Path2D/PathFollow2D
	path_follow_2d.progress_ratio = randf()
	new_enemy.position = path_follow_2d.position
	# definir rotaçao
	var enemy_rotation = path_follow_2d.rotation + PI/2
	enemy_rotation += randf_range(-PI/4, PI/4)
	new_enemy.rotation = enemy_rotation
	# movimentaçao
	var velocity = Vector2(new_enemy.speed_enemy, 0)
	new_enemy.linear_velocity = velocity.rotated(new_enemy.rotation)

func _on_chaser_timer_timeout() -> void:
	var chaser = chaser_scene.instantiate()
	# add_child primeiro, pelo mesmo motivo acima
	add_child(chaser)  
	var path_follow_2d = $Path2D/PathFollow2D
	path_follow_2d.progress_ratio = randf() 
	 # posição aleatória nas bordas da tela assim como o enemy 
	chaser.position = path_follow_2d.position

func spawn_bomb():
	var bomb = bomb_scene.instantiate()
	# Posição aleatória no centro da tela (dica do professor)
	add_child(bomb)
	# get_viewport_rect().size retorna as dimensões da tela (ex: 480x720)
	var screen = get_viewport_rect().size
	bomb.position = Vector2(
		randf_range(50, screen.x - 50),
		randf_range(50, screen.y - 50)
	)
	
func _on_bomb_timer_timeout() -> void:
	spawn_bomb()
	
func _on_item_timer_timeout() -> void:
	var item = item_scene.instantiate()
	add_child(item)
	var screen = get_viewport_rect().size
	item.position = Vector2(
		randf_range(50, screen.x - 50),
		randf_range(50, screen.y - 50)
	)
	
func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

		
func _on_player_hit() -> void:
	game_over()

func _on_hud_start() -> void:
	start_game()
