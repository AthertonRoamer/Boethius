class_name CreditsLabel
extends Label

var credits : int = 0:
	set(v):
		credits = v
		update_label()
		
		
func update_label() -> void:
	text = "Credits: " + str(credits)
