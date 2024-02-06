extends AttackActor

class_name Player

signal player_goto(direction: String)

var decel: float
@onready var sprite: AnimatedSprite2D = $Sprite

func take_damage(dmg: int) -> void:
	self.health -= dmg
	if self.health < 0:
		self.health = 12
		self.sprite.play("dead")
		self.process_mode = Node.PROCESS_MODE_DISABLED

func move_player(delta: float) -> void:
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	if dir != Vector2.ZERO:
		self.velocity = dir.normalized() * self.speed
	else:
		self.velocity.x = move_toward(self.velocity.x, 0.0, self.decel * delta)
		self.velocity.y = move_toward(self.velocity.y, 0.0, self.decel * delta)
	
	self.animate_player(dir)
	self.move_and_slide()

func animate_player(dir: Vector2) -> void:
	if dir != Vector2.ZERO:
		if dir.x < 0: self.direction = "left"
		elif dir.x > 0: self.direction = "right"
		elif dir.y < 0: self.direction = "up"
		else: self.direction = "down"
	
	if self.velocity != Vector2.ZERO:
		self.sprite.play("walk_" + self.direction)
	else:
		self.sprite.play("idle_" + self.direction)

func is_player_goto() -> void:
	if self.global_position.x < self.global_scale.x and self.direction == "left":
		self.player_goto.emit("left")
	elif self.global_position.x > 320 and self.direction == "right":
		self.player_goto.emit("right")
	elif self.global_position.y < self.global_scale.y and self.direction == "up":
		self.player_goto.emit("top")
	elif self.global_position.y > 180 and self.direction == "down":
		self.player_goto.emit("bottom")

func _physics_process(delta: float) -> void:
	self.move_player(delta)
	self.is_player_goto()

func _ready() -> void:
	self.decel = self.speed * 9
	self.global_position = DataSystem.player.position
	self.health = DataSystem.player.health
