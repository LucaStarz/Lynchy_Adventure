extends Node

@onready var corruption_scene: Resource = preload("res://scenes/menus/corruption_scene.tscn")

class ConfigData:
	var lang: String = TranslationServer.get_locale()
	
	static func data_file() -> String:
		return "config.lad"
	
	static func encryption() -> String:
		return "9=9,bQ5N]T39i7-r7)8_W4KH6pSAv*!tgKU8zh9+:?}zVNg4CTd4[%82/.qchsAN"
	
	func read() -> void:
		if FileAccess.file_exists(ConfigData.data_file()):
			var file: FileAccess = FileAccess.open_encrypted_with_pass(ConfigData.data_file(), FileAccess.READ, ConfigData.encryption())
			var data: Dictionary = JSON.parse_string(file.get_as_text())
			if data == null: DataSystem.goto_corruption_scene()
			
			self.lang = data.get("lang")
		else:
			self.write()
	
	func write() -> void:
		var file: FileAccess = FileAccess.open_encrypted_with_pass(ConfigData.data_file(), FileAccess.WRITE, ConfigData.encryption())
		if file == null: DataSystem.goto_corruption_scene()

		var data: Dictionary = {
			"lang": self.lang
		}
		file.store_string(JSON.stringify(data))

class PlayerData:
	var zone: int = 0
	var position: Vector2 = Vector2(175, 45)
	
	static func data_file() -> String:
		return "user://player.lad"
	
	static func encryption() -> String:
		return "CF7iW8;*Zf,^Myi+J(44zP757b[k6:%sz675p9Ai]H3uX3?E}_VC4!{bgR@c6rQE"
	
	func read() -> void:
		if FileAccess.file_exists(PlayerData.data_file()):
			var file: FileAccess = FileAccess.open_encrypted_with_pass(PlayerData.data_file(), FileAccess.READ, PlayerData.encryption())
			var data: Dictionary = JSON.parse_string(file.get_as_text())
			if data == null: DataSystem.goto_corruption_scene()
			
			self.zone = data.get("zone")
			self.position.x = data.get("x")
			self.position.y = data.get("y")
		else:
			self.write()
	
	func write() -> void:
		var file: FileAccess = FileAccess.open_encrypted_with_pass(PlayerData.data_file(), FileAccess.WRITE, PlayerData.encryption())
		if file == null: DataSystem.goto_corruption_scene()

		var data: Dictionary = {
			"zone": self.zone,
			"x": self.position.x,
			"y": self.position.y
		}
		file.store_string(JSON.stringify(data))

var player: PlayerData
var config: ConfigData
func _ready() -> void:
	self.player = PlayerData.new()
	self.player.read()
	
	self.config = ConfigData.new()
	self.config.read()
	
	self.__DEBUG__()
	TranslationServer.set_locale(self.config.lang)

func _exit_tree() -> void:
	self.player.write()
	self.config.write()

func goto_corruption_scene() -> void:
	get_tree().change_scene_to_packed(self.corruption_scene)

func repopulate() -> void:
	self.player = PlayerData.new()
	self.player.write()
	
	self.config = ConfigData.new()
	self.config.write()

func __DEBUG__() -> void:
	self.config.lang = "fr"
