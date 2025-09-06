extends TextureRect

@onready var dialogBox: PanelContainer = $DialogBox;
@onready var dialogText: RichTextLabel = $DialogBox/BoxMargin/DialogText;
@onready var mascotAnimations: AnimationPlayer = $MascotAnimations;

const clementinaTextures: Array[Texture2D] = [
	preload("res://Assets/Clementina_parada.png"),
	preload("res://Assets/Clementina_saludando.png"),
	preload("res://Assets/Clementina_pensando.png")
];

const mascotDialogs: Array[String] = [
	"",
	"[b]¡Bienvenido/a![/b]
Soy Clementina y voy a ayudarte a completar tu CVar.
¿Estás listo/a para comenzar?",
	"Tener tu [b]CVAR al día[/b] es como tener tu mochila lista:
¡todo preparado para tu próximo desafío académico!"
];

func _ready() -> void:
	mascotAnimations.play("RESET");
	hide();
	dialogBox.hide();
	dialogText.text = mascotDialogs[0];

func _on_progress_bar_value_changed(value: float) -> void:
	var textIndex: int = int(value);
	
	dialogBox.hide();
	show();
	texture = clementinaTextures[0];
	mascotAnimations.play("transition" + str(textIndex));

func _on_mascot_animations_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"transition1":
			dialogText.text = mascotDialogs[1];
			texture = clementinaTextures[1];
			dialogBox.show();
		"transition2":
			dialogText.text = mascotDialogs[2];
			texture = clementinaTextures[2];
			dialogBox.show(); 
