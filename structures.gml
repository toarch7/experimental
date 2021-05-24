global.seenDisSword = false

#define game_start
global.seenDisSword = false

#define structure_cond_handler
var data = argument0
var id = data.id

switch (id) {
	case "DismasSword":
		return !global.seenDisSword;
	break
}

#define structure_gen_handler
var x = argument0
var y = argument1
var data = argument2
var id = data.id

print(data);

switch (id) {
	case "DismasSword":
		print("nu dopustim")
		global.seenDisSword = true;
	break
}