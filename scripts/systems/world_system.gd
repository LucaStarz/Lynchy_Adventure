extends Node2D

var player: Player
var camera: Camera2D
var current: Node2D

func _ready() -> void:
	self.player = (load("res://scenes/actors/players/player_%s.tscn" % DataSystem.config.player)).instantiate()
	self.player.name = "Player"
	self.player.process_mode = PROCESS_MODE_PAUSABLE
	self.player.player_goto.connect(self._on_player_goto)
	self.add_child(self.player)
	self.camera = self.player.get_node("Camera")
	
	self.current = (load("res://scenes/zones/%s.tscn" % DataSystem.player.zone)).instantiate()
	self.add_child(self.current)

	self.camera.limit_top = 0
	self.camera.limit_left = 0
	self.camera.limit_right = 320
	self.camera.limit_bottom = 180

func _on_player_goto(direction: String) -> void:
	var goto: Node2D = null
	
	match direction:
		"left":
			if self.current.left >= 0: 
				goto = (load("res://scenes/zones/%s.tscn" % self.current.left)).instantiate()
				goto.global_position.x = -320
				goto.global_position.y = 0
		
		"right":
			if self.current.right >= 0: 
				goto = (load("res://scenes/zones/%s.tscn" % self.current.right)).instantiate()
				goto.global_position.x = 320
				goto.global_position.y = 0
		
		"top":
			if self.current.top >= 0: 
				goto = (load("res://scenes/zones/%s.tscn" % self.current.top)).instantiate()
				goto.global_position.y = -180
				goto.global_position.x = 0
		
		"bottom":
			if self.current.bottom >= 0: 
				goto = (load("res://scenes/zones/%s.tscn" % self.current.bottom)).instantiate()
				goto.global_position.y = 180
				goto.global_position.x = 0

	if goto != null:
		goto.process_mode = Node.PROCESS_MODE_DISABLED
		self.add_child(goto)
		self.current.process_mode = Node.PROCESS_MODE_DISABLED
		self.player.process_mode = Node.PROCESS_MODE_DISABLED
		
		var distance_restante: float = goto.global_position.distance_to(Vector2.ZERO)
		while distance_restante > 0:
			var dir: Vector2 = (Vector2.ZERO - goto.global_position).normalized()
			var distance_deplacement: float = 300 * get_physics_process_delta_time()
			if distance_deplacement > distance_restante:
				distance_deplacement = distance_restante
	
			goto.global_position += dir * distance_deplacement
			self.current.global_position += dir * distance_deplacement
			self.player.global_position += dir * distance_deplacement
			distance_restante -= distance_deplacement
			await $Timer.timeout
		
		self.current.queue_free()
		self.current = goto
		self.current.process_mode = Node.PROCESS_MODE_PAUSABLE
		self.player.process_mode = Node.PROCESS_MODE_PAUSABLE
