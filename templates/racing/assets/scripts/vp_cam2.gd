extends Control

# editor will enumerate as 0, 1 for both of following
export(int, "Player One", "Player Two") var player_number
export(int, "Horizontal Split", "Vertical Split") var split_screen_type

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_tree().get_root().connect("size_changed", self, "_on_screen_resolution_changed")
	
	# set position depends on player number
	adapt_to_settings()

func adapt_to_settings():
	# get current window size
	var window_size = OS.get_window_size()
	
	# player one
	if player_number == 0:
		# horizontal split
		if split_screen_type == 0:
			set_pos(Vector2(0,0))
			set_size(Vector2(window_size.width/2, window_size.height))
		# vertical split
		else:
			set_pos(Vector2(0,0))
			set_size(Vector2(window_size.width, window_size.height/2))
	# player two
	else:
		# horizontal split
		if split_screen_type == 0:
			set_pos(Vector2(window_size.width/2, 0))
			set_size(Vector2(window_size.width/2, window_size.height))
		# vertical split
		else:
			set_pos(Vector2(0, window_size.height/2))
			set_size(Vector2(window_size.width, window_size.height/2))
	
	print("adapted to settings");

func _on_screen_resolution_changed():
	adapt_to_settings()
