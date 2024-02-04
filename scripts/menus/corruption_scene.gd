extends ColorRect

@onready var title: Label = $Title

func _ready() -> void:
	title.text = tr("title_corrupted", )
