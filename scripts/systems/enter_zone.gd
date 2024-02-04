extends Area2D

class_name EnterZone

@export_enum("left", "right", "top", "bottom") var direction: String

signal is_enter_zone(dir: String)

func _on_body_entered(_body: Node2D) -> void:
	self.is_enter_zone.emit(self.direction)
