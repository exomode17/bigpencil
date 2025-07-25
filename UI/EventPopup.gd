extends Window

@onready var label_title = $VBoxContainer/LabelTitle
@onready var label_desc = $VBoxContainer/LabelDesc
@onready var button_close = $VBoxContainer/ButtonClose

func show_event(event_data):
    label_title.text = event_data.title
    label_desc.text = event_data.description
    show()

func _ready():
    button_close.pressed.connect(hide)

func show_event(event_data):
    label_title.text = event_data.title
    label_desc.text = event_data.description
    $SFX.play()
    show()
