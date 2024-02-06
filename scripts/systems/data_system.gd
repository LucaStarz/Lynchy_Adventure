extends Node

@onready var corruption_scene: Resource = preload("res://scenes/menus/corruption_scene.tscn")

class ConfigData:
	var lang: String = TranslationServer.get_locale()
	var player: String = "green"
	
	static func data_file() -> String:
		return "user://config.lad"
	
	static func encryption() -> String:
		return "9=9,bQ5N]T39i7-r7)8_W4KH6pSAv*!tgKU8zh9+:?}zVNg4CTd4[%82/.qchsAN"
	
	func read() -> bool:
		if FileAccess.file_exists(ConfigData.data_file()):
			var file: FileAccess = FileAccess.open_encrypted_with_pass(ConfigData.data_file(), FileAccess.READ, ConfigData.encryption())
			if file == null: return false
			
			var data: Dictionary = JSON.parse_string(file.get_as_text())
			if data == null: return false
			elif not data.has_all(["lang", "player"]): 
				return false
			
			self.lang = data.get("lang")
			self.player = data.get("player")
			return true
		else:
			return self.write()
	
	func write() -> bool:
		var file: FileAccess = FileAccess.open_encrypted_with_pass(ConfigData.data_file(), FileAccess.WRITE, ConfigData.encryption())
		if file == null: return false

		var data: Dictionary = {
			"lang": self.lang,
			"player": self.player
		}
		file.store_string(JSON.stringify(data))
		return true

class PlayerData:
	var zone: int = 0
	var position: Vector2 = Vector2(175, 45)
	var health: int = 12
	var max_health: int = 12
	
	static func data_file() -> String:
		return "user://player.lad"
	
	static func encryption() -> String:
		return "CF7iW8;*Zf,^Myi+J(44zP757b[k6:%sz675p9Ai]H3uX3?E}_VC4!{bgR@c6rQE"
	
	func read() -> bool:
		if FileAccess.file_exists(PlayerData.data_file()):
			var file: FileAccess = FileAccess.open_encrypted_with_pass(PlayerData.data_file(), FileAccess.READ, PlayerData.encryption())
			if file == null: return false
				
			var data: Dictionary = JSON.parse_string(file.get_as_text())
			if data == null: return false
			elif not data.has_all(["zone", "x", "y", "health", "max_health"]): 
				return false
			
			self.zone = data.get("zone")
			self.position.x = data.get("x")
			self.position.y = data.get("y")
			self.health = data.get("health")
			self.max_health = data.get("max_health")
			
			if self.health > self.max_health: return false
			return true
		else:
			return self.write()
	
	func write() -> bool:
		var file: FileAccess = FileAccess.open_encrypted_with_pass(PlayerData.data_file(), FileAccess.WRITE, PlayerData.encryption())
		if file == null: return false

		var data: Dictionary = {
			"zone": self.zone,
			"x": self.position.x,
			"y": self.position.y,
			"health": self.health,
			"max_health": self.max_health
		}
		file.store_string(JSON.stringify(data))
		return true

class GlobalsData:
	var blue_slime_killed: int = 0
	var green_bamboo_killed: int = 0
	var yellow_bamboo_killed: int = 0
	
	static func data_file() -> String:
		return "user://globals.lad"
	
	static func encryption() -> String:
		return "=#5gr8ZUrhSVY@S8$x55;*8_.66W/qW4J2nKy?4~M,c4-28%4AE[cvPaw(zS9Dgs"
	
	func read() -> bool:
		
		return true
	
	func write() -> bool:
		var file: FileAccess = FileAccess.open_encrypted_with_pass(GlobalsData.data_file(), FileAccess.WRITE, GlobalsData.encryption())
		if file == null: return false
		
		var data: Dictionary = {
			"blue_slime": self.blue_slime_killed,
			"green_bamboo": self.green_bamboo_killed,
			"yellow_bamboo": self.yellow_bamboo_killed
		}
		file.store_string(JSON.stringify(data))
		return true


var player: PlayerData
var config: ConfigData
func _ready() -> void:
	var timer: Timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = 900
	timer.timeout.connect(DataSystem.launch_save)
	self.add_child(timer)
	timer.start()
	
	self.player = PlayerData.new()
	if not self.player.read(): self.goto_corruption_scene()
	
	self.config = ConfigData.new()
	if not self.config.read(): self.goto_corruption_scene()
	
	#self.__DEBUG__()
	
	if self.config.lang not in TranslationServer.get_loaded_locales(): self.config.lang = "en"
	TranslationServer.set_locale(self.config.lang)

func goto_corruption_scene() -> void:
	await get_tree().tree_changed
	get_tree().change_scene_to_packed(self.corruption_scene)

func repopulate() -> bool:
	self.player = PlayerData.new()
	if not self.player.write(): return false
	
	self.config = ConfigData.new()
	if not self.config.write(): return false
	return true

func launch_save() -> void:
	var pl: Player = get_tree().root.get_node("WorldSystem/Player")
	self.player.zone = get_tree().root.get_node("WorldSystem").current.id
	self.player.position = pl.global_position
	self.player.health = pl.health
	self.player.write()
	
	self.config.write()

func __DEBUG__() -> void:
	self.config.lang = "de"
