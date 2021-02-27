extends Node

var Nds = []  # węzły
var NUM = 20
var e = 0.0 # wsp. restytucji

var node_object = load("material_point.tscn")
var slap = load("res://slap.wav")

onready var ASP = $"../AudioStreamPlayer"
onready var grav = $grav

func _ready():
	create_scene()

func _process(delta):
	pass

func _physics_process(delta):
	for i in range(Nds.size()):
		for j in range(i):
			var dist = (Nds[i].position - Nds[j].position)
			if(dist.length() < Nds[i].radius() + Nds[j].radius()):
				var n = dist.normalized()
				ASP.stream = slap
				ASP.play(0)
				var vI = Nds[i].velocity
				var vJ = Nds[j].velocity
				var mI = Nds[i].mass
				var mJ = Nds[j].mass
				var vIn = vI.dot(n)
				var vJn = vJ.dot(n)
				var Jdmm = (e + 1)*(vJn-vIn)/(mI+mJ)
				Nds[i].velocity +=  Jdmm*mJ*n - vIn*n
				Nds[j].velocity += -Jdmm*mI*n - vJn*n
				Nds[i].euler(delta)
				Nds[j].euler(delta)

func create_scene():
	# initialize points
	for i in range(NUM):
		var new_node  = node_object.instance()
		var r     = 0.5
		var phi   = 2*PI*randf()
		var theta = -0.5*PI + PI*randf()
		new_node.position = r*Vector3(cos(phi)*sin(theta),cos(theta),sin(phi)*sin(theta))
		Nds.push_back(new_node)
		add_child(new_node)
