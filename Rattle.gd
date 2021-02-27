extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var bottom_wall = [
	Vector3(-1.0, 0.0, -1.0),
	Vector3(-1.0, 0.0, 1.0),
	Vector3(2.0, 0.0, 1.0),
	Vector3(2.0, 0.0, -1.0)
]

var back_wall = [
	Vector3(-1.0, 0.0, -1.0),
	Vector3(-1.0, 0.0, 1.0),
	Vector3(-1.0, 1.0, 1.0),
	Vector3(-1.0, 1.0, -1.0),
]

var front_wall = [
	Vector3(2.0, 0.0, 1.0),
	Vector3(2.0, 0.0, -1.0),
	Vector3(1.0, 2.0, -1.0),
	Vector3(1.0, 2.0, 1.0)
]

var top_wall = [
	Vector3(-1.0, 1.0, 1.0),
	Vector3(-1.0, 1.0, -1.0),
	Vector3(1.0, 2.0, -1.0),
	Vector3(1.0, 2.0, 1.0)
]

var left_wall = [
	Vector3(-1.0, 0.0, -1.0),
	Vector3(-1.0, 1.0, -1.0),
	Vector3(2.0, 0.0, -1.0),
	Vector3(1.0, 2.0, -1.0),
]

var right_wall = [
	Vector3(-1.0, 0.0, 1.0),
	Vector3(-1.0, 1.0, 1.0),
	Vector3(2.0, 0.0, 1.0),
	Vector3(1.0, 2.0, 1.0),
]

var walls = [bottom_wall, back_wall, front_wall, top_wall, left_wall, right_wall]

var normals = []
var alphas = []

func _ready():
	calculate_data()

func _physics_process(delta):
	pass
	
func get_triangle_normal(surface):
	var side1 = surface[1] - surface[0]
	var side2 = surface[2] - surface[0]
	var normal = side1.cross(side2)
	return normal
	
func get_alphas(surface):
	return (-get_triangle_normal(surface)).dot(surface[0])
	
func calculate_data():
	for wall in walls:
		normals.push_back(get_triangle_normal(wall))
		alphas.push_back(get_alphas(wall))
	
