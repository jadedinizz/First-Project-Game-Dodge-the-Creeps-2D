extends Area2D

signal hit 

@export var speed = 400
var base_speed = 400
var direction = Vector2.ZERO
var screen_size
	
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	speed = base_speed
	
func _process(delta):
	proccess_input(delta)
	update_animations()	
	
func proccess_input(delta):
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"): 
		direction.x = 1	
	if Input.is_action_pressed("move_left"):
		direction.x = -1	
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	if Input.is_action_pressed("move_down"):
		direction.y = 1
		
	position += direction * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func update_animations():
	if direction != Vector2.ZERO:
		if direction.x != 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = direction.x < 0
			$AnimatedSprite2D.flip_v = false
		elif direction.y != 0:
			$AnimatedSprite2D.play("up")
			$AnimatedSprite2D.flip_v = direction.y > 0
	else:
		$AnimatedSprite2D.stop()
	
func _on_body_entered(body: Node2D):
	# is_in_group() identifica com qual objeto o player colidiu
	if body.is_in_group("enemy"): # só morre se for inimigo
		hit.emit()
	if body.is_in_group("item"):
		body.queue_free()    # remove o item da tela
		apply_speed_boost()
		get_tree().get_root().get_node("Main/SpeedSound").play()
		
	if body.is_in_group("bomb"):
		body.queue_free()    # remove a bomba da tela
		# Elimina todos os nodes do grupo "enemy" simultaneamente
		get_tree().call_group("enemy", "queue_free")
		# Acessa o ExplosionSound pelo caminho da árvore
		get_tree().get_root().get_node("Main/ExplosionSound").play()

func apply_speed_boost():
	speed = base_speed * 2  # dobra a velocidade
	# create_timer() cria um timer temporário sem precisar de um node Timer
	# await pausa a execução aqui até o tempo acabar
	await get_tree().create_timer(5.0).timeout
	speed = base_speed  # restaura após 5 segundos
