extends Viewport

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_tree().get_root().connect("size_changed", self, "_on_screen_resolution_changed")

func _on_screen_resolution_changed():
	# update camera's rect when window resolution changed
	var window_size = OS.get_window_size()
	set_rect(Rect2(0, 0, window_size.width, window_size.height))
