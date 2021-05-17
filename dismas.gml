/// For faster work

//init
global.duelistTarget = {
	id: -4,
	hits: 0
}

/// Dynamite
#define active_item
var user = argument0
var item = argument1

if item == "dis_dynamite" {
	var dynamite = instance_create(user.x, user.y, Dynamite);
	dynamite.direction = user.wepangle
	dynamite.speed = 8
	dynamite.friction = 0.1
	dynamite.team = user.team
	dynamite.creator = user
	dynamite.image_speed = 0.2
}

/// Flawless dagger effect
#define hit_dismas_sword
var attacker = argument0
var victim = argument1
var proj = argument2

if !victim.__dismas_sword_bonus {
	victim.__dismas_sword_bonus = 0
}

if entity_take_damage(victim, calculate_damage(
	proj.damage, victim.armor,
	attacker.damage + victim.__dismas_sword_bonus / 2),
attacker, proj) {
	victim.__dismas_sword_bonus ++;
}

/// Duelist - deal more damage to single target.
#define entity_hit
var attacker = argument0
var victim = argument1

if instance_exists(attacker) && attacker.object_index == Player && player_get_char(attacker) == "dismas" {
	var _target = global.duelistTarget;
	
	if _target.id != victim {
		attacker.damage -= _target.hits
		
		_target.id = victim
		_target.hits = 0
	} else {
		attacker.damage ++;
		_target.hits ++;
	}
}

/// Visuals
#define draw
var target = global.duelistTarget.id;
var wave = get_timer() / 500000;

if target && instance_exists(target) {
	draw_sprite_ext(sprDismasDuelistMark, 0, target.x, target.y - target.z - 18 - sin(wave) * 3, 1, 1, 0, c_red, 1 + sin(wave) * 0.5);
}


/// Fix some stuff
#define room_end
var player = player_get();

if instance_exists(player) && player_get_char(player) == "dismas" {
	player.damage -= global.duelistTarget.hits;
}

global.duelistTarget = { id: -4, hits: 0 };


/// Unlock
#define enemy_kill
var enemy = argument0
var last_hit = argument1
var last_hitproj = argument2

if (enemy.is_boss && !char_is_unlocked("dismas")) {
	var player = player_get();
	
	if (player.char == 0 && player.weapon == "cheap_sword" && player.second_weapon == "none") {
		char_unlock("dismas");
	}
}