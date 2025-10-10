extends MarginContainer;

@onready var progressBar: TextureProgressBar = $TextureProgressBar;
@onready var mainContainer: VBoxContainer = $TextContainer/MainContainer;
@onready var title: RichTextLabel = $TextContainer/MainContainer/Title;
@onready var description: RichTextLabel = $TextContainer/MainContainer/Description;
@onready var imageContainer: PanelContainer = $TextContainer/MainContainer/ImageContainer;
@onready var image: TextureRect = $TextContainer/MainContainer/ImageContainer/Image;
@onready var main: Control = get_parent();
@onready var mainButton: Button = $ButtonContainer/MainButton;
@onready var backButton: Button = $ButtonContainer/BackButton;
@onready var infoButton: Button = $Info;

const titleTexts: Array = [
	"[b]Guía paso a paso[/b]\npara completar tu [b]CVAR[/b]",
	"",
	"",
	"
	[b]¿Qué es CVar?[/b]",
	"[b]Objetivos[/b]",
	"[b]Formulario de registro[/b]",
	"[b]Confirmación por mail[/b]",
	"[b]Inicio de sesión[/b]",
	"[b]Cambio de contraseña[/b]",
	"[b]Selección de rol[/b]",
	"",
	"[b]Datos Personales[/b]",
	"[b]Formación Académica[/b]",
	"[b]Antecedentes en C y T[/b]",
	"[b]Imprimir CV[/b]",
	"[b]¡Felicidades![/b]
Completaste el tutorial :)",
	"PRUEBA1"
];

const descriptionTexts: Array = [
	"Un [b]recorrido interactivo[/b] para que cargues tu información de manera simple y rápida.",
	"",
	"",
	"
		El [b]Curriculum Vitae Argentino[/b] (CVar) es una [b]herramienta digital[/b] donde los investigadores, docentes 
		y becarios registran su producción académica y profesional.
		Tenerlo actualizado facilita tu participación en convocatorias, becas y proyectos de investigación.",
	"
	
[b]Módulo 1: Registro[/b]
	- Llenar formulario de registro
	- Confirmación por mail
	- Inicio de sesión
	- Cambio de contraseña
	
	
[b]Módulo 2: Formulario[/b]
	- Selección de rol
	- Llenar formulario
	- Imprimir CV",
	"Usá esta guía todas las veces que necesites, está para acompañarte en el proceso.",
	"PRUEBA1"
];

const buttonTexts: Array = [
	"¡Estoy listo/a!",
	"¡Entendido!",
	"Siguiente",
	"Finalizar",
	"Comenzar de nuevo"
];

const images: Array = [
	preload("res://Assets/Tutorial/formulario_registro.png"),
	preload("res://Assets/Tutorial/comprobacion_mail.png"),
	preload("res://Assets/Tutorial/inicio_sesion.png"),
	preload("res://Assets/Tutorial/cambio_contraseña.png"),
	preload("res://Assets/Tutorial/seleccion_rol.png"),
	preload("res://Assets/Tutorial/datos_personales.png"),
	preload("res://Assets/Tutorial/formacion_academica.png"),
	preload("res://Assets/Tutorial/antecedentes_cyt.png"),
	preload("res://Assets/Tutorial/imprimir_cv.png")
];

var textIndex: int;

func _ready() -> void:
	backButton.hide();
	title.text = titleTexts[0];
	description.text = descriptionTexts[0];

func _on_progress_bar_value_changed(value: float) -> void:
	textIndex = int(value);
	
	match textIndex:
		5:
			imageContainer.show();
			image.texture = images[0];
			title.text = titleTexts[textIndex];
		6:
			imageContainer.show();
			image.texture = images[1];
			title.text = titleTexts[textIndex];
		7:
			imageContainer.show();
			image.texture = images[2];
			title.text = titleTexts[textIndex];
		8:
			imageContainer.show();
			image.texture = images[3];
			title.text = titleTexts[textIndex];
		9:
			imageContainer.show();
			image.texture = images[4];
			title.text = titleTexts[textIndex];
		10:
			imageContainer.hide();
		12:
			imageContainer.hide();
		13:
			imageContainer.hide();
		14:
			mainButton.text = buttonTexts[3];
			imageContainer.show();
			image.texture = images[8];
			title.text = titleTexts[textIndex];
		15:
			imageContainer.hide();
			title.text = "";

func _on_mascot_animations_animation_finished(anim_name: StringName) -> void:
	textIndex = int(progressBar.value);
	
	match anim_name:
		"transition2":
			$TextContainer.add_theme_constant_override("margin_bottom", 32);
			mainButton.text = buttonTexts[0];
			title.text = titleTexts[textIndex];
			description.text = descriptionTexts[textIndex];
		"transition3":
			mainContainer.alignment = BoxContainer.ALIGNMENT_BEGIN;
			mainButton.text = buttonTexts[1];
			$ButtonContainer.size_flags_horizontal = Control.SIZE_SHRINK_END;
			title.text = titleTexts[textIndex];
			description.text = descriptionTexts[textIndex];
		"transition4":
			mainButton.text = buttonTexts[2];
			title.text = titleTexts[textIndex];
			description.text = descriptionTexts[textIndex];
		"transition6":
			imageContainer.show();
			image.texture = images[5];
			title.text = titleTexts[textIndex];
		"transition7":
			imageContainer.show();
			image.texture = images[6];
			title.text = titleTexts[textIndex];
		"transition8":
			imageContainer.show();
			image.texture = images[7];
			title.text = titleTexts[textIndex];
		"despedida":
			$TextContainer.add_theme_constant_override("margin_bottom", 96);
			title.text = titleTexts[textIndex];
			description.text = descriptionTexts[5];
			mainButton.text = buttonTexts[4];
			mainContainer.alignment = BoxContainer.ALIGNMENT_CENTER;
			$ButtonContainer.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;
			mainButton.show();

func _on_main_button_pressed() -> void:
	if (progressBar.value < 15.0):
		title.text = "";
		description.text = "";
		imageContainer.hide();
		progressBar.set_value(progressBar.value + 1.0);
		mainButton.hide();
		backButton.hide();
		infoButton.hide();
	else:
		get_tree().reload_current_scene();

func _on_back_button_pressed() -> void:
	title.text = "";
	description.text = "";
	imageContainer.hide();
	progressBar.set_value(progressBar.value - 1.0);
	mainButton.hide();
	backButton.hide();
	infoButton.hide();
