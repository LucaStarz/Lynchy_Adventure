extends Node2D

var player: Player
var camera: Camera2D

var already: bool = false
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
	self.camera.limit_right = self.current.width
	self.camera.limit_bottom = self.current.height

func _on_player_goto(direction: String) -> void:
	var goto: Node2D = null
	match direction:
		"left":
			if self.current.left >= 0: 
				goto = (load("res://scenes/zones/%s.tscn" % self.current.left)).instantiate()
				self.current.global_position.x = goto.width
				self.player.global_position.x = goto.width - 2
		
		"right":
			if self.current.right >= 0: 
				goto = (load("res://scenes/zones/%s.tscn" % self.current.right)).instantiate()
				self.current.global_position.x = -goto.width
				self.player.global_position.x = 2
		
		"top":
			if self.current.top >= 0: 
				goto = (load("res://scenes/zones/%s.tscn" % self.current.top)).instantiate()
				self.current.global_position.y = goto.height
				self.player.global_position.y = goto.height - 2
		
		"bottom":
			if self.current.bottom >= 0: 
				goto = (load("res://scenes/zones/%s.tscn" % self.current.bottom)).instantiate()
				self.current.global_position.y = -goto.height
				self.player.global_position.y = 2

	if goto != null:
		self.add_child(goto)
		self.current.process_mode = Node.PROCESS_MODE_DISABLED
		self.current = goto
