extends Node2D

@onready var zones: Node2D = $Zones
@onready var camera: Camera2D = $PlayerGreen/Camera

var current: PackedScene
var left: PackedScene
var right: PackedScene
var top: PackedScene
var bottom: PackedScene

func _ready() -> void:
	self.current = load("res://scenes/zones/%s.tscn" % DataSystem.player.zone)
	
	var current_scene: Node = self.current.instantiate()
	current_scene.name = "Current"
	self.zones.add_child(current_scene)

	self.camera.limit_top = 0
	self.camera.limit_left = 0
	self.camera.limit_right = 320
	self.camera.limit_bottom = 180
