extends Panel

@onready var main_menu: Resource = preload("res://scenes/menus/main_menu.tscn")

func _ready() -> void:
	self.visible = false
	$Titre.text = tr("title_pause_menu")
	$ResumeButton.text = tr("resume_pause_menu")
	$MainMenuButton.text = tr("title_main_menu")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if not self.visible: $ResumeButton.grab_focus()
		get_tree().paused = not get_tree().paused
		self.visible = not self.visible

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	self.visible = false

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(self.main_menu)
