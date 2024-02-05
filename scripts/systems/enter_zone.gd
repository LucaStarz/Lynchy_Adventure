extends Area2D

class_name EnterZone

signal is_enter_zone(entity: Node2D)
signal is_left_zone(entity: Node2D)

func _on_body_entered(body: Node2D) -> void:
	self.is_enter_zone.emit(body)

func _on_body_exited(body: Node2D) -> void:
	self.is_left_zone.emit(body)
