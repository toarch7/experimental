#define init
global.DiscordPerk = {
	active: false,
	orbital: -4,
	sound: -4
}

#define step
var player = player_get();

if instance_exists(player) {
	var index = player.index;
	
	var dis = global.DiscordPerk;
	var orb = dis.orbital;
	
	if instance_exists(orb) {
		if !instance_exists(dis.sound) {
			dis.sound = snd3d_play_vol(orb.x, orb.y, sndSound, 0, 0.1);
		} else {
			var sound = dis.sound;
			sound.x = orb.x;
			sound.y = orb.y;
		}
	} else if get_perk("discord", index) {
		orb = instance_create(player.x, player.y, MeteorOrbital);
		
		orb.creator = player;
		orb.team = player.team;
		
		orb.sprite_index = sprAbilityDiscord;
		
		dis.orbital = orb;
		
		sound_stop_music();
	}
	
	if get_perk("sack", index) && !level_generating() && random(1) < 0.67 {
		var bullet = instance_create(player.x, player.y, RobotBlast)
		
		bullet.team = player.team;
		bullet.direction = random(360);
		bullet.image_angle = bullet.direction;
		bullet.speed = 6;
		bullet.creator = player;
	}
}