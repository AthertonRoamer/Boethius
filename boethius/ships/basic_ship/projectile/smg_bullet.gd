extends Projectile
class_name SmgBullet

var faction : Ship.Faction
var dying : bool = false

func extinguish() -> void:
	$AnimationPlayer.play("blow up")
	dying = true
	
	
func update_position(delta) -> void:
	if !dying:
		position += velocity * delta
	else:
		velocity = Vector2.ZERO


func _ready() -> void:
	super()
	if wielder.faction == wielder.Faction.PLAYER:
		$Sprite2D.frame = 2
	else:
		$Sprite2D.frame = 3


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
