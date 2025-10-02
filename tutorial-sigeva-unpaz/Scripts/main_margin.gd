extends MarginContainer

@onready var progressBar: ProgressBar = $ProgressBar;
@onready var mainContainer: VBoxContainer = $TextContainer/MainContainer;
@onready var title: RichTextLabel = $TextContainer/MainContainer/Title;
@onready var description: RichTextLabel = $TextContainer/MainContainer/Description;
@onready var image: TextureRect = $TextContainer/MainContainer/Image;
@onready var main: Control = get_parent();
@onready var mainButton: Button = $MainButton;
@onready var infoButton: Button = $Info

const titleTexts: Array = [
	"[b]Guía paso a paso[/b]\npara completar tu [b]CVAR[/b]",
	"",
	"
	[b]¿Qué es CVAR?[/b]",
	"PRUEBA1"
];

const descriptionTexts: Array = [
	"Un [b]recorrido interactivo[/b] para que cargues tu información de manera simple y rápida.",
	"",
	"
	El [b]Curriculum Vitae Argentino[/b] (CVAR) es una [b]herramienta digital[/b] donde los
	investigadores, docentes y becarios registran su producción académica y profesional.
	Tenerlo actualizado facilita tu participación en convocatorias, becas y proyectos de investigación.",
	"PRUEBA1"
];

const buttonTexts: Array = [
	"¡Estoy listo/a!",
	"¡Entendido!",
	"Siguiente"
]

func _ready() -> void:
	progressBar.hide();
	title.text = titleTexts[0];
	description.text = descriptionTexts[0];

func _on_mascot_animations_animation_finished(anim_name: StringName) -> void:
	var textIndex: int = int(progressBar.value);
	title.text = titleTexts[textIndex];
	description.text = descriptionTexts[textIndex];
	
	match anim_name:
		"transition1":
			mainButton.show();
			mainButton.text = buttonTexts[0]
		"transition2":
			mainButton.show();
			mainContainer.alignment = BoxContainer.ALIGNMENT_BEGIN;
			mainButton.text = buttonTexts[1]
			mainButton.size_flags_horizontal = Control.SIZE_SHRINK_END;
		"transition3":
			mainButton.hide();
			mainButton.text = buttonTexts[2]
			mainButton.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;

func _on_main_button_pressed() -> void:
	progressBar.set_value(progressBar.value + 1.0);
	mainButton.hide();
	infoButton.hide();
	
	title.text = "";
	description.text = "";
