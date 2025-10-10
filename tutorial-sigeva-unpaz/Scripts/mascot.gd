extends TextureRect;

@onready var mainMargin: MarginContainer = get_parent().get_node("MainMargin");

@onready var mascotAnimations: AnimationPlayer = $MascotAnimations;

const clementinaTextures: Array[Texture2D] = [
	preload("res://Assets/Clementina/Parada.png"),
	preload("res://Assets/Clementina/Saludando_der.png"),
	preload("res://Assets/Clementina/Saludando_izq.png"),
	preload("res://Assets/Clementina/Pensando.png"),
	preload("res://Assets/Clementina/Guiñando.png")
];

const mascotDialogs: Array[String] = [
	"",
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
datos personales para continuar.",
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
	"Para [b]cargar un proyecto[/b] de extensión,
asegurate de tener a mano la [b]sinopsis[/b] y
el [b]resumen[/b] del mismo.",
	"Recordá: [b]marcá todas las casillas,
completá la fecha y descargá tu CV[/b]
en formato .pdf o .doc y ¡Listo!",
	"Si venís del exterior y [b]no[/b] contás con
CUIL/CUIT, no te preocupes: podés
registrarte con tu [b]Pasaporte.[/b]",
	"Este diálogo no debería aparecer"
];

var textIndex: int = 1;
var tween: Tween;

func _ready() -> void:
	mascotAnimations.play("RESET");
	hide();

func _on_progress_bar_value_changed(value: float) -> void:
	var previousTextIndex: int = textIndex; 
	textIndex = int(value);
	texture = clementinaTextures[0];
	
	if (previousTextIndex < 5 and textIndex < 5):
		if (!visible): show();
		if (textIndex > previousTextIndex): mascotAnimations.play("transition" + str(textIndex));
		else: mascotAnimations.play_backwards("transition" + str(previousTextIndex));
	else: 
		if previousTextIndex == 5 and previousTextIndex > textIndex:
			mascotAnimations.play("transition4",  -1, 0.0, true);
			mascotAnimations.animation_finished.emit("transition4");
	match textIndex:
		5:
			texture = clementinaTextures[2];
			var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-408.0, -180.0), Vector2(464.0, 128.0), 464.0, mascotDialogs[textIndex], false);
			add_child(newDialog);
		6:
			texture = clementinaTextures[0];
			var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-288.0, -180.0), Vector2(416.0, 128.0), 460.0, mascotDialogs[textIndex], true);
			add_child(newDialog);
		7:
			var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-352.0, -118.0), Vector2(460.0, 128.0), 460.0, mascotDialogs[textIndex], true);
			add_child(newDialog);
		8:
			texture = clementinaTextures[2];
			var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-288.0, -160.0), Vector2(406.0, 128.0), 406.0, mascotDialogs[textIndex], true);
			add_child(newDialog);
		9:
			if (textIndex >= previousTextIndex):
				var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-288.0, -180.0), Vector2(460.0, 160.0), 500.0, mascotDialogs[textIndex], true);
				add_child(newDialog);
			else: mascotAnimations.play_backwards("transition5");
		10:
			if (textIndex >= previousTextIndex):
				texture = clementinaTextures[0];
				mascotAnimations.play("transition5");
			else: mascotAnimations.play_backwards("transition6");
		11:
			if (textIndex >= previousTextIndex):
				mascotAnimations.play("transition6");
			else: mascotAnimations.play_backwards("transition7");
		12:
			if (textIndex >= previousTextIndex):
				flip_h = false;
				mascotAnimations.play("transition7");
			else: mascotAnimations.play_backwards("transition8");
		13:
			if (textIndex > previousTextIndex):
				texture = clementinaTextures[0];
				mascotAnimations.play("transition8");
			else:
				mascotAnimations.play("transition8",  -1, 0.0, true);
				mascotAnimations.animation_finished.emit("transition8");
		14:
			texture = clementinaTextures[0];
			var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-224.0, -186.0), Vector2(232.0, 180.0), 464.0, mascotDialogs[textIndex], true);
			add_child(newDialog);
		15:
			mascotAnimations.play("despedida");

func _on_mascot_animations_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"transition2":
			texture = clementinaTextures[1];
			var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(336.0, -96.0), Vector2(0.0, 119.0), 654.0, mascotDialogs[textIndex], true);
			add_child(newDialog);
		"transition3":
			if (mascotAnimations.get_current_animation_position() == mascotAnimations.get_current_animation_length()):
				texture = clementinaTextures[3];
				var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(320.0, 64.0), Vector2(0.0, 59.5), 634.0, mascotDialogs[textIndex], true);
				add_child(newDialog);
			else: 
				mascotAnimations.play("transition2",  -1, 0.0, true);
				mascotAnimations.animation_finished.emit("transition2");
		"transition4":
			if (mascotAnimations.get_current_animation_position() == mascotAnimations.get_current_animation_length()):
				texture = clementinaTextures[2];
				var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-380.0, -140.0), Vector2(518.0, 128.0), 518.0, mascotDialogs[textIndex], true);
				add_child(newDialog);
			else: 
				mascotAnimations.play("transition3",  -1, 0.0, true);
				mascotAnimations.animation_finished.emit("transition3");
		"transition5":
			if (mascotAnimations.get_current_animation_position() == mascotAnimations.get_current_animation_length()):
				var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(320.0, -32.0), Vector2(0.0, 128.0), 570.0, mascotDialogs[textIndex], true);
				add_child(newDialog);
			else: _on_progress_bar_value_changed(9.0);
		"transition6":
			if (mascotAnimations.get_current_animation_position() == mascotAnimations.get_current_animation_length()):
				texture = clementinaTextures[3];
				var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-416.0, 32.0), Vector2(448.0, 100.0), 448.0, mascotDialogs[textIndex], true);
				add_child(newDialog);
				flip_h = true;
			else: 
				flip_h = false;
				mascotAnimations.play("transition5",  -1, 0.0, true);
				mascotAnimations.animation_finished.emit("transition5");
		"transition7":
			if (mascotAnimations.get_current_animation_position() == mascotAnimations.get_current_animation_length()):
				texture = clementinaTextures[2];
				var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-320.0, -96.0), Vector2(390.0, 100.0), 390.0, mascotDialogs[textIndex], true);
				add_child(newDialog);
			else:
				mascotAnimations.play("transition6",  -1, 0.0, true);
				mascotAnimations.animation_finished.emit("transition6");
		"transition8":
			if (mascotAnimations.get_current_animation_position() == mascotAnimations.get_current_animation_length()):
				texture = clementinaTextures[2];
				var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-368.0, -192.0), Vector2(416.0, 224.0), 506.0, mascotDialogs[textIndex], false);
				add_child(newDialog);
			else:
				mascotAnimations.play("transition7",  -1, 0.0, true);
				mascotAnimations.animation_finished.emit("transition7");
		"despedida":
			_ready();

func addDialogBox() -> void:
	if (textIndex == 5):
		texture = clementinaTextures[4];
		var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-408.0, 8.0), Vector2(464.0, 96.0), 464.0, mascotDialogs[15], true);
		add_child(newDialog);
	if (textIndex == 13):
		texture = clementinaTextures[0];
		var newDialog = DialogBox.newDialogBox(mainMargin, Vector2(-368.0, 0.0), Vector2(390.0, 64.0), 390.0, mascotDialogs[12], true);
		add_child(newDialog);
