extends Control

@onready var creditsAnimation: AnimationPlayer = $CreditsAnimation;

func _process(_delta: float) -> void:
	if ($Credits.modulate.a == 1.0 and Input.is_action_pressed("ui_accept")):
		creditsAnimation.play("fade_out");

func _on_info_pressed() -> void:
	creditsAnimation.play("fade_in");
