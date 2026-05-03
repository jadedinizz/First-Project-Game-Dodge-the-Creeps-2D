# 🎮 Dodge the Creeps

Jogo 2D desenvolvido com **Godot Engine 4.4** como projeto prático da disciplina de **Desenvolvimento de Jogos**.

Baseado no tutorial oficial do Godot ["Your First 2D Game"](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html), com mecânicas adicionais implementadas como exercícios da disciplina.

---

## 🕹️ Como Jogar

- Use as **setas do teclado** ou **WASD** para mover o personagem
- **Desvie** dos inimigos que surgem pelas bordas da tela
- **Colete itens verdes** para ganhar boost de velocidade temporário
- **Colete bombas** para eliminar todos os inimigos da tela
- O jogo termina ao colidir com um inimigo
- Sobreviva o maior tempo possível e acumule pontos!

---

## ✨ Funcionalidades

### Inimigos base (Enemy)
- Surgem pelas bordas da tela em intervalos regulares
- Cada tipo de inimigo possui velocidade própria:
  - **Walk** — 90.0
  - **Swim** — 120.0
  - **Fly** — 180.0

### Inimigo Perseguidor (Chaser)
- Aparece a cada **30 segundos**
- Persegue o jogador ativamente por **5 segundos**
- Após desistir, sai pela tela em direção aleatória
- É um fly maior que os outros e com cor avermelhada

### Item de Velocidade
- Aparece a cada **10 segundos** em posição aleatória na tela
- Ao ser coletado, **dobra a velocidade** do jogador por 5 segundos
- Identificado pelo ícone de raio

### Bomba
- Aparece a cada **20 segundos** em posição aleatória na tela
- Ao ser coletada, **elimina todos os inimigos** da tela simultaneamente
- Identificado pelo ícone de bomba

---

## 📚 Conceitos de Godot Aplicados

| Conceito | Onde foi usado |
|---|---|
| `_ready()` e ciclo de vida dos nodes | Inicialização de variáveis em `enemy.gd` e `chaser.gd` |
| `_physics_process()` | Perseguição contínua do Chaser ao Player |
| `RigidBody2D` e `linear_velocity` | Movimentação de inimigos e Chaser |
| `StaticBody2D` | Bomba e Item parados na tela |
| `Area2D` e sinal `body_entered` | Detecção de colisão do Player |
| Grupos (`is_in_group`) | Identificação do tipo de objeto colidido |
| `call_group()` | Eliminação simultânea de todos os inimigos |
| `SceneTree.create_timer()` | Timer temporário para o boost de velocidade |
| `modulate` | Alteração de cor dos sprites sem nova imagem |
| Collision Layer e Mask | Separação de camadas físicas entre objetos |
| `Path2D` e `PathFollow2D` | Spawn dos inimigos pelas bordas da tela |
| `PackedScene` e `instantiate()` | Criação dinâmica de objetos na cena |

---

## 📁 Estrutura do Projeto

```
projeto/
├── scenes/
│   ├── main.tscn       # Cena principal do jogo
│   ├── player.tscn     # Player
│   ├── enemy.tscn      # Inimigo base
│   ├── chaser.tscn     # Inimigo perseguidor
│   ├── hud.tscn        # Interface (score, mensagens, botão)
│   ├── bomb.tscn       # Bomba
│   └── item.tscn       # Item de velocidade
├── scripts/
│   ├── main.gd         # Lógica principal (spawn, score, game over)
│   ├── player.gd       # Movimentação e colisões do jogador
│   ├── enemy.gd        # Comportamento do inimigo base
│   ├── chaser.gd       # Comportamento do inimigo perseguidor
│   ├── hud.gd          # Interface (score, mensagens, botão)
│   ├── bomb.gd         # Script da bomba
│   └── item.gd         # Script do item
├── audio/              # Sons do jogo
├── images/             # Sprites e texturas
└── fonts/              # Fontes utilizadas na UI
```

---

## 🚀 Como Executar

1. Instale o [Godot Engine 4.4](https://godotengine.org/download)
2. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/dodge-the-creeps.git
   ```
3. Abra o Godot → **Importar Projeto** → selecione a pasta do repositório
4. Pressione **F5** ou clique em **Executar** para jogar

---

