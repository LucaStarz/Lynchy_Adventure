extends Area2D

class_name EnterZone

@export_enum("left", "right", "top", "bottom") var direction: String

signal is_enter_zone(player: Player, dir: String)
signal is_left_zone(player: Player, dir: String)

func _on_body_entered(body: Node2D) -> void:
	self.is_enter_zone.emit(body, self.direction)

func _on_body_exited(body: Node2D) -> void:
	self.is_left_zone.emit(body, self.direction)
