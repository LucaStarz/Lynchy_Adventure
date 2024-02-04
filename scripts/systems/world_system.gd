extends Node2D

@onready var zones: Node2D = $Zones

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
