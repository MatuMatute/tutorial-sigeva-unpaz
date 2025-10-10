extends PanelContainer;
class_name DialogBox;

const dialogBoxScene: PackedScene = preload("res://dialog_box.tscn");
const textReadSpeed = 0.03;

@onready var dialogText: RichTextLabel = $BoxMargin/DialogText;

var mainMargin: MarginContainer;
var isLastDialog: bool;
var textTween: Tween;
var Dialog: String = "";
var tweenDuration: float;

static func newDialogBox(mainMarginReference: MarginContainer, startPosition: Vector2, pivot: Vector2, width: float, text: String, lastDialog: bool) -> DialogBox:
	var Box = dialogBoxScene.instantiate()
	Box.mainMargin = mainMarginReference;
	Box.position = startPosition;
	Box.pivot_offset = pivot;
	Box.size.x = width;
	Box.Dialog = text;
	Box.isLastDialog = lastDialog;
	return Box;

func _ready() -> void:
	mainMargin.mainButton.pressed.connect(queue_free);
	mainMargin.backButton.pressed.connect(queue_free);
	dialogText.text = Dialog;
	tweenDuration = textReadSpeed * Dialog.length();
	var start_tween = create_tween();
	start_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.5);
	start_tween.finished.connect(showDialog)
	start_tween.play();

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and textTween != null:
		textTween.custom_step(tweenDuration);

func showDialog() -> void:
	textTween = create_tween();
	textTween.tween_method(dialogText.set_visible_ratio, 0.0, 1.0, tweenDuration);
	textTween.finished.connect(textTween.kill);
	if (isLastDialog):
		textTween.finished.connect(mainMargin.buttonContainer.show);
	else: textTween.finished.connect(get_parent().addDialogBox)
	textTween.play();
