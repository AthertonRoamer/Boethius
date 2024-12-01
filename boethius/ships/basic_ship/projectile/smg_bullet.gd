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
	faction = wielder.faction
	if wielder.faction == Ship.Faction.PLAYER:
		$Sprite2D.frame = 2

		set_collision_mask_value(4,true)
	else:
		$Sprite2D.frame = 3
		set_collision_mask_value(5,true)



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
	
	
func effect_body(body : Node2D) -> void:
	var extinguish_triggered : bool = false
	if body.get("faction") == faction:
		return
	if body.is_in_group("damageable"):
		body.take_damage(damage, damage_type)
		hit_entities.append(body)
		extinguish_triggered = true
	if body.is_in_group("knockable") and impact_knockback > 0:
		body.take_knockback(impact_knockback * velocity.normalized())
		extinguish_triggered = true
	if extinguish_on_effect_body and extinguish_triggered:
		extinguish()
