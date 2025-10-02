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
¡todo preparado para tu próximo desafío académico!",
	"Este diálogo no debería aparecer"
];

var textIndex: int;

func _ready() -> void:
	mascotAnimations.play("RESET");
	hide();
	dialogBox.hide();
	dialogText.text = mascotDialogs[0];

func _on_progress_bar_value_changed(value: float) -> void:
	textIndex = int(value);
	
	dialogBox.hide();
	show();
	texture = clementinaTextures[0];
	mascotAnimations.play("transition" + str(textIndex));

func _on_mascot_animations_animation_finished(anim_name: StringName) -> void:
	if (anim_name != "RESET" and anim_name != "growBubble"):
		dialogText.text = mascotDialogs[textIndex];
		dialogBox.pivot_offset =  dialogBox.position.direction_to(position) * dialogBox.size;
		dialogText.visible_ratio = 0.0;
		mascotAnimations.play("growBubble");
	if (anim_name == "growBubble"): showDialog();
	match anim_name:
		"transition1":
			texture = clementinaTextures[1];
		"transition2":
			texture = clementinaTextures[2];

func showDialog() -> void:
	var tween = create_tween();
	tween.tween_method(dialogText.set_visible_ratio, 0.0, 1.0, 3.0);
	tween.play();
