#define entity_hit
var attacker = argument0
var victim = argument1

if instance_exists(victim) && victim.object_index == Player && victim.hat == "harm_mask" {
	entity_take_damage(attacker, calculate_damage(7.5, 0, victim.damage), victim, noone);
	
	snd3d_play(attacker.x, attacker.y, sndEnemyHurt, 0);
	entity_apply_effect(victim, "regen", 10, 0.1, true)
}