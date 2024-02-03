extends CharacterBody2D

class_name Player

@export var speed: float = 100.0
var decel: float = speed * 9

var direction: String = "down"

@onready var sprite: AnimatedSprite2D = $Sprite

func move_player(delta: float):
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	if dir != Vector2.ZERO:
		self.velocity = dir.normalized() * speed
	else:
		self.velocity.x = move_toward(self.velocity.x, 0.0, self.decel * delta)
		self.velocity.y = move_toward(self.velocity.y, 0.0, self.decel * delta)
	
	self.animate_player(dir)
	self.move_and_slide()

func animate_player(dir: Vector2):
	if dir != Vector2.ZERO:
		if dir.x < 0: self.direction = "left"
		elif dir.x > 0: self.direction = "right"
		elif dir.y < 0: self.direction = "up"
		else: self.direction = "down"
	
	if self.velocity != Vector2.ZERO:
		self.sprite.play("walk_" + self.direction)
	else:
		self.sprite.play("idle_" + self.direction)

func _physics_process(delta: float):
	self.move_player(delta)

