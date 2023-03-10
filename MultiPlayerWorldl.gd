extends Spatial

var player = preload("res://MultiPlayer/Player1.tscn")

func _ready():
	get_tree().connect("network_peer_connected", self ,"_player_connected")
	get_tree().connect("network_peer_disconnected", self ,"_player_disconnected")

	Camu.connect("instance_player", self, "_instance_player")
	
	if get_tree().network_peer != null:
		Camu.emit_signal("toggle_network_setup", false)

func _instance_player(id):
	var player_instance = player.instance()
	player_instance.set_network_master(id)
	
	add_child(player_instance)
	player_instance.global_transform.origin = Vector3(0, 15, 0)
	
func _player_connected(id):
	print("Player" + str(id) + "has connected.")
	_instance_player(id)


func _player_disconnected(id):
	print("Nagyon nem megyen")
	if has_node(str(id)):
		get_node(str(id)).queue_free()
