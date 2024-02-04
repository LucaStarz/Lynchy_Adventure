extends CharacterBody2D

class_name Bamboo

@export_group("Characteristics")
@export var speed: float = 40.0
@export var damage: int = 1

@onready var sprite: AnimatedSprite2D = $Sprite
var direction: String = "down"
var goto: Player

func animate_bamboo() -> void:
	var dir: Vector2 = self.goto.global_position - self.global_position if self.goto != null else Vector2.ZERO
	if dir != Vector2.ZERO:
		if dir.y < 0: self.direction = "up"
		elif dir.y > 0: self.direction = "down"
		elif dir.x < 0: self.direction = "left"
		else: self.direction = "right"
	
	if self.velocity != Vector2.ZERO:
		self.sprite.play("walk_" + self.direction)
	else:
		self.sprite.play("idle_" + self.direction)

func move_bamboo() -> void:
	if self.goto != null:
		self.velocity = (self.goto.global_position - self.global_position).normalized() * self.speed
	else:
		self.velocity = Vector2.ZERO
	
	self.move_and_slide()

func _physics_process(_delta: float) -> void:
	self.move_bamboo()
	self.animate_bamboo()

func _on_enter_zone_is_enter_zone(player: Player, _dir: String) -> void:
	self.goto = player

func _on_enter_zone_is_left_zone(_player: Player, _dir: String) -> void:
	self.goto = null
