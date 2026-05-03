extends RigidBody2D

var speed = 155.0
var chasing = true
var player = null

func _ready():
	# Busca o Player pelo grupo "player" — mesmo sistema de grupos
	# já usado na colisão do player.gd com is_in_group()
	player = get_tree().get_first_node_in_group("player")

	# modulate muda a cor do sprite sem precisar de nova imagem
	# Color(R, G, B) — valores entre 0.0 e 1.0
	# Aqui usamos roxo para diferenciar do inimigo normal
	$AnimatedSprite2D.modulate = Color(1.2, 0.0, 0.5)

	# scale aumenta o tamanho do node inteiro (sprite + colisão)
	# Vector2(2.0, 2.0) = duas vezes maior em X e Y
	scale = Vector2(2.0, 2.0)

	# Toca uma animação (fly é a mais rápida visualmente)
	$AnimatedSprite2D.play("fly")

	# Timer interno para parar de perseguir após 5 segundos
	var chase_timer = Timer.new()
	chase_timer.wait_time = 5.0
	chase_timer.one_shot = true  # dispara apenas uma vez
	chase_timer.timeout.connect(_stop_chasing)
	add_child(chase_timer)
	chase_timer.start()

# _physics_process roda a cada frame de física (60x por segundo)
# É onde atualizamos a direção de perseguição continuamente
func _physics_process(_delta):
	if chasing and player != null:
		# Calcula vetor DO chaser ATÉ o player: destino - origem
		# .normalized() mantém só a direção, com comprimento 1
		# Multiplicamos por speed para definir a velocidade final
		var direction = (player.position - position).normalized()
		linear_velocity = direction * speed
		
		$AnimatedSprite2D.rotation = direction.angle()
func _stop_chasing():
	chasing = false
	# TAU = 2*PI = 360 graus em radianos (constante nativa do Godot)
	# Aplica velocidade em direção aleatória para sair da tela
	linear_velocity = Vector2(speed, 0).rotated(randf() * TAU)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
