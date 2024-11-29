extends Control


var step = "mit"

func _ready() -> void:
	loadin()

func loadin():
	$load_timer.start()

func _on_load_timer_timeout() -> void:
	match step:
		"mit":
			$AnimationPlayer.play("Mitnik")
			step = "three"
			loadin()
			return
		"three":
			$AnimationPlayer.play("3")
			step = "pause"
			loadin()
			return
		"pause":
			step = "fade"
			loadin()
			return
		"fade":
			$AnimationPlayer.play("fade")
			step = "finish"
			loadin()
			return
		"finish":
			$AnimationPlayer.play("finish")
			step = "menu"
			loadin()
			return
		"menu":
			$AnimationPlayer.play("menu")
			return


func _on_button_pressed():
	Main.main.load_game()
