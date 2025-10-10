extends Control;

# Este script manipula los círculos que aparecen y se mueven en el fondo desenfocados (blur) con un shader.
var orange_circle_position: Vector2 = Vector2(1280, randf_range(0, 360));
var aquamarine_circle_position: Vector2 = Vector2(1280, randf_range(360, 720));
var blue_circle_position: Vector2 = Vector2(0, randf_range(360, 720));
var lily_circle_position: Vector2 = Vector2(0, randf_range(0, 360));

var orange_circle_speed: Vector2 = Vector2(-1.0, -1.0);
var aquamarine_circle_speed: Vector2 = Vector2(-0.5, -0.5);
var blue_circle_speed: Vector2 = Vector2(1.0, 1.0);
var lily_circle_speed: Vector2 = Vector2(0.5, 0.5)

func _draw() -> void:
	draw_rect(Rect2(0, 0, 1280, 720), Color.LAVENDER);
	draw_circle(orange_circle_position, 256.0, Color.LIGHT_SALMON);
	draw_circle(blue_circle_position, 256.0, Color.SKY_BLUE);
	draw_circle(lily_circle_position, 160.0, Color.SKY_BLUE);
	draw_circle(aquamarine_circle_position, 160.0, Color.LIGHT_SALMON);

func _process(_delta: float) -> void:
	orange_circle_position += orange_circle_speed;
	orange_circle_speed = circle_rotation(orange_circle_position, orange_circle_speed);
	
	blue_circle_position += blue_circle_speed;
	blue_circle_speed = circle_rotation(blue_circle_position, blue_circle_speed);
	
	lily_circle_position += lily_circle_speed;
	lily_circle_speed = circle_rotation(lily_circle_position, lily_circle_speed);
	
	aquamarine_circle_position += aquamarine_circle_speed;
	aquamarine_circle_speed = circle_rotation(aquamarine_circle_position, aquamarine_circle_speed);
	
	queue_redraw();

func circle_rotation(circle_position : Vector2, circle_speed : Vector2) -> Vector2:
	if (circle_position.x < -96.0):
		randomize();
		circle_speed.x = randf_range(0.2, 1.0);
	
	if (circle_position.x > 1320.0):
		randomize();
		circle_speed.x = randf_range(-1.0, -0.2);
	
	if (circle_position.y < -96.0):
		randomize();
		circle_speed.y = randf_range(0.2, 1.0);
	
	if (circle_position.y > 800.0):
		randomize();
		circle_speed.y = randf_range(-0.2, -1.0);
	
	return circle_speed
