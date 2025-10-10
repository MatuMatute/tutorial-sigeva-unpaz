extends Control

@onready var creditsAnimation: AnimationPlayer = $MainAnimation;

func _on_info_pressed() -> void:
	creditsAnimation.play("fade_in");

func _on_back_pressed() -> void:
	creditsAnimation.play("fade_out");

func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on);
