extends Control

func _ready() -> void:
	if OS.get_name() != "Android" && OS.get_name() != "iOS":
		$Android.visible = DataSystem.config.onscreen


func _on_button_up_button_down() -> void:
	Input.action_press("up")

func _on_button_up_button_up() -> void:
	Input.action_release("up")

func _on_button_down_button_down() -> void:
	Input.action_press("down")

func _on_button_down_button_up() -> void:
	Input.action_release("down")

func _on_button_left_button_down() -> void:
	Input.action_press("left")

func _on_button_left_button_up() -> void:
	Input.action_release("left")

func _on_button_right_button_down() -> void:
	Input.action_press("right")

func _on_button_right_button_up() -> void:
	Input.action_release("right")

func _on_button_pause_button_down() -> void:
	Input.action_press("escape")

func _on_button_pause_button_up() -> void:
	Input.action_release("escape")
