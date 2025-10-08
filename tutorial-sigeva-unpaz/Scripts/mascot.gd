extends TextureRect

@onready var mainMargin: MarginContainer = get_parent().get_node("MainMargin");
@onready var dialogBox: PanelContainer = $DialogBox;
@onready var dialogText: RichTextLabel = $DialogBox/BoxMargin/DialogText;
@onready var mascotAnimations: AnimationPlayer = $MascotAnimations;

const clementinaTextures: Array[Texture2D] = [
	preload("res://Assets/Clementina_parada.png"),
	preload("res://Assets/Clementina_saludando_der.png"),
	preload("res://Assets/Clementina_saludando_izq.png"),
	preload("res://Assets/Clementina_pensando.png"),
	preload("res://Assets/Clementina_guiñando.png")
];

const mascotDialogs: Array[String] = [
	"",
	"[b]¡Bienvenido/a![/b]
Soy Clementina y voy a ayudarte a completar tu CVar.
¿Estás listo/a para comenzar?",
	"Tener tu [b]CVar al día[/b] es como tener tu mochila lista:
¡todo preparado para tu próximo desafío académico!",
	"Estos son los pasos que vas a completar.
Seguí el orden para avanzar en el tutorial
y lograr tu registro en CVar.",
	"Este es el [b]formulario de registro[/b].
Tenés que completarlo con tus
datos personales para continuar.
Si venís del exterior y [b]no[/b] contás con
CUIL/CUIT, no te preocupes: podés
registrarte con tu [b]Pasaporte.[/b]",
	"¡Listo! Ahora [b]revisá tu correo:[/b] vas a
recibir un [b]mail de confirmación[/b] con
un enlace para continuar.",
	"Ahora entrarás con el usuario que 
creaste y [b]la contraseña que te llegó
por mail.[/b]",
	"Ahora solo queda [b]iniciar sesión
nuevamente[/b] con tu [b]nueva
contraseña[/b]",
	"Para continuar, elegí la primera opción:
[b]Usuario banco de datos de actividades
de CyT[/b]",
	"Una vez seleccionado el Rol, verás un gran
formulario para llenar, [b]nos enfocaremos[/b], por 
ahora, en estas secciones: [b]Datos personales[/b],
[b]Formación Académica[/b] y [b]Antecedentes[/b].",
	'Haz click en el [b]botón "Sin datos"[/b]
para completar con tu información',
	'Haz click en el [b]botón "0"[/b] para
completar con tu información',
	'Para [b]cargar un proyecto[/b] de extensión,
asegurate de tener a mano la [b]sinopsis[/b] y
el [b]resumen[/b] del mismo.
Haz click en el [b]botón "0"[/b] para
completar con tu información',
	"Recordá: [b]marcá todas las casillas,
completá la fecha y descargá tu CV[/b]
en formato .pdf o .doc y ¡Listo!",
	"Este diálogo no debería aparecer"
];

const tweenDuration: float = 3.0;

var textIndex: int;
var tween: Tween;

func _ready() -> void:
	mascotAnimations.play("RESET");
	hide();
	dialogBox.hide();
	dialogText.text = mascotDialogs[0];

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and tween != null:
		tween.custom_step(tweenDuration);

func _on_progress_bar_value_changed(value: float) -> void:
	textIndex = int(value);
	show();
	dialogBox.hide();
	texture = clementinaTextures[0];
	
	if (textIndex < 4): mascotAnimations.play("transition" + str(textIndex));
	else:
		match textIndex:
			4:
				texture = clementinaTextures[4];
				dialogBox.position = Vector2(-384.0, -180.0);
				dialogBox.size = Vector2(464.0, 100.0);
				dialogText.size = Vector2(464.0, 100.0);
				dialogBox.pivot_offset = Vector2(464.0, 128.0);
				growBubble();
			5:
				texture = clementinaTextures[0];
				dialogBox.position.x = -288.0;
				growBubble();
				dialogBox.size = Vector2(460.0, 100.0);
				dialogText.size = Vector2(460.0, 100.0);
			6:
				dialogBox.position = Vector2(-352.0, -118.0);
				#dialogBox.size = Vector2(460.0, 100.0);
				#dialogText.size = Vector2(460.0, 100.0);
				growBubble();
			7:
				texture = clementinaTextures[2];
				dialogBox.position = Vector2(-288.0, -160.0);
				dialogBox.size = Vector2(406.0, 100.0);
				dialogText.size = Vector2(406.0, 100.0);
				growBubble();
			8:
				dialogBox.position = Vector2(-288.0, -180.0);
				dialogBox.size = Vector2(500.0, 100.0);
				dialogText.size = Vector2(500.0, 100.0);
				dialogBox.pivot_offset = Vector2(460.0, 160.0);
				growBubble();
			9:
				texture = clementinaTextures[0];
				dialogText.size = Vector2(570.0, 200.0);
				dialogBox.size = Vector2(570.0, 200.0);
				dialogBox.pivot_offset = Vector2(0.0, 128.0);
				mascotAnimations.play("transition4");
			10:
				dialogBox.pivot_offset = Vector2(448.0, 100.0);
				mascotAnimations.play("transition5");
			11:
				flip_h = false;
				dialogBox.pivot_offset = Vector2(390.0, 100.0);
				mascotAnimations.play("transition6");
			12:
				texture = clementinaTextures[0];
				dialogBox.pivot_offset = Vector2(416.0, 224.0);
				dialogText.size = Vector2(506.0, 100.0);
				dialogBox.size = Vector2(506.0, 100.0);
				mascotAnimations.play("transition7");
			13:
				texture = clementinaTextures[0];
				dialogBox.position = Vector2(-224.0, -186.0);
				dialogBox.pivot_offset = Vector2(232.0, 180.0);
				growBubble();
				dialogText.size = Vector2(464.0, 100.0);
				dialogBox.size = Vector2(464.0, 100.0);
			14:
				mascotAnimations.play("despedida");

func _on_mascot_animations_animation_finished(anim_name: StringName) -> void:
	if (anim_name != "RESET" and anim_name != "growBubble" and anim_name != "despedida"):
		growBubble();
	if (anim_name == "growBubble"): showDialog();
	match anim_name:
		"transition1":
			texture = clementinaTextures[1];
			dialogBox.size = Vector2(654.0, 166.0);
			dialogText.size = Vector2(654.0, 166.0);
			dialogBox.pivot_offset = Vector2(0.0, 119.0);
		"transition2":
			texture = clementinaTextures[3];
			dialogBox.size = Vector2(634.0, 100.0);
			dialogText.size = Vector2(634.0, 100.0);
			dialogBox.pivot_offset = Vector2(0.0, 59.5);
		"transition3":
			texture = clementinaTextures[2];
			dialogBox.size = Vector2(518.0, 100.0);
			dialogText.size = Vector2(518.0, 100.0);
			dialogBox.pivot_offset = Vector2(518.0, 128.0);
		"transition5":
			texture = clementinaTextures[3];
			dialogText.size = Vector2(448.0, 100.0);
			dialogBox.size = Vector2(448.0, 100.0);
			flip_h = true;
		"transition6":
			texture = clementinaTextures[2];
			dialogText.size = Vector2(390.0, 100.0);
			dialogBox.size = Vector2(390.0, 100.0);
		"transition7":
			texture = clementinaTextures[2];

func growBubble() -> void:
	dialogText.text = mascotDialogs[textIndex];
	dialogText.visible_ratio = 0.0;
	mascotAnimations.play("growBubble");

func showDialog() -> void:
	tween = create_tween();
	tween.tween_method(dialogText.set_visible_ratio, 0.0, 1.0, tweenDuration);
	tween.finished.connect(tween.kill);
	tween.finished.connect(mainMargin.mainButton.show);
	tween.finished.connect(mainMargin.backButton.show);
	tween.play();
