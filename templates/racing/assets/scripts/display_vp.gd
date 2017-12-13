extends Control

export var split_screen_type = 0;

func _ready():
	set_process(true);
	get_tree().get_root().connect("size_changed", self, "_on_screen_resolution_changed")

func _process(delta):
	update();

func _on_screen_resolution_changed():
	# update its size when window resolution changed
	var window_size = OS.get_window_size()
	set_size(Vector2(window_size.width, window_size.height))

func _draw():
	var draw_p1 = false;
	var draw_p2 = false;
	
	if has_node("/root/game/env/player1"):
		draw_p1 = true;
	if has_node("/root/game/env/player2"):
		draw_p2 = true;
	
	var control_rect = get_rect();
	
	if draw_p1 && !draw_p2:
		var p1_vp = get_node("/root/game/env/player1/vp");
		p1_vp.set_rect(control_rect);
		
		var p1_tex = p1_vp.get_render_target_texture();
		draw_texture_rect(p1_tex, control_rect, false);
	
	elif !draw_p1 && draw_p2:
		var p2_vp = get_node("/root/game/env/player2/vp");
		p2_vp.set_rect(control_rect);
		
		var p2_tex = p2_vp.get_render_target_texture();
		draw_texture_rect(p2_tex, control_rect, false);
	
	elif draw_p1 && draw_p2:
		control_rect.pos = Vector2();
		if split_screen_type == 0:
			control_rect.size.x /= 2;
		elif split_screen_type == 1:
			control_rect.size.y /= 2;
		
		var p1_vp = get_node("/root/game/env/player1/vp");
		p1_vp.set_rect(control_rect);
		
		var p1_tex = p1_vp.get_render_target_texture();
		draw_texture_rect(p1_tex, control_rect, false);
		
		if split_screen_type == 0:
			control_rect.pos.x += control_rect.size.x;
		elif split_screen_type == 1:
			control_rect.pos.y += control_rect.size.y;
		
		var p2_vp = get_node("/root/game/env/player2/vp");
		p2_vp.set_rect(control_rect);
		
		var p2_tex = p2_vp.get_render_target_texture();
		draw_texture_rect(p2_tex, control_rect, false);