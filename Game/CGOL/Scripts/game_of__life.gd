# GAME OF LIFE

extends Node2D

var grid = {} # dictionary to hold all the cells

export var width = 10	# total cells wide
export var height = 10	# total cells tall
export var cell_size = 32   # width/height of the graphic in pixels
export var spawn_rate = 50	# percentage to start living
var spacer = 5              # distance between cells

var start_position	# position to start the grid
var step_timer	# time between each step

var cell = preload("res://scenes/cell.tscn")

func _ready():
	start_position = get_node("StartPosition")
	step_timer = get_node("StepTimer")
 
func initialize_grid():
	for y in height:
		for x in width:
			var new_cell = cell.instance()
			new_cell.initialize_tile(x,y)
			new_cell.rect_position = (Vector2(start_position.position.x + x*(cell_size+spacer), start_position.position.y + y*(cell_size+spacer)))
			add_child(new_cell)
			grid[Vector2(x,y)] = new_cell  

func randomize_grid():
	for y in height:
		for x in width:
			var cell = grid[Vector2(x,y)]
			if rand_range(1,101) <= spawn_rate:
				cell.set_type(0)
			else:
				cell.set_type(1)

	randomize()
	start_position = get_node("StartPosition")
	step_timer = get_node("StepTimer")
	initialize_grid()
	randomize_grid()
