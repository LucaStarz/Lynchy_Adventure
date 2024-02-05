extends Node2D

class_name Zone

@export var id: int

@export_group("Size")
@export var width: int
@export var height: int
@export var place_x: int
@export var place_y: int

@export_group("Neighbours")
@export var left: int
@export var right: int
@export var top: int
@export var bottom: int
