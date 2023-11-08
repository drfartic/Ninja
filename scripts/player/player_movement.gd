extends CharacterBody2D

@onready var current_mouse_pos = Vector2(0,0);
var mouse_down_pos;
var is_mouse_held;

@onready var aim_line = $AimLine

func _unhandled_input( event ):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			is_mouse_held = true;
			mouse_down_pos = get_global_mouse_position();
			Engine.time_scale = 0.15;
		elif event.button_index == 1 and not event.is_pressed():
			is_mouse_held = false;
			Engine.time_scale = 1;
			do_dash();

func _physics_process(delta):
	velocity += Vector2(0, 900) * delta;
	
	handle_dash_direction();
	move_and_slide();

func handle_dash_direction():
	if is_mouse_held:
		current_mouse_pos = get_global_mouse_position();
		aim_line.set_point_position(1, (current_mouse_pos - mouse_down_pos).limit_length(150));
		aim_line.show();
	else:
		aim_line.hide();

func do_dash():
	velocity = (current_mouse_pos - mouse_down_pos).limit_length(200)*3;
