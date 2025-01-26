extends RichTextLabel
class_name CycleUI

var new_string : String = "Cycle"
var init_text: String = "[center] {text} [/center]"
var timer: Timer
var freq: float = 15.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_text = self.text
	timer = Timer.new()
	timer.set_wait_time(2.6 * 2 * (1.0/freq))
	timer.set_one_shot(true)
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_cycle_number(number: int) -> void:
	print("Cycle number updated: " + str(number))
	new_string = "CYCLE: " + str(number)
	self.text = "[center][wave amp=40.0 freq=" + str(freq) + "connected=1]" + new_string + "[/wave]"
	timer.start()

func _on_timer_timeout() -> void:
	self.text = "[center]" + new_string
	pass

