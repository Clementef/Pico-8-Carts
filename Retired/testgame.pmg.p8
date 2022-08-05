pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
--game loop

function _init()
	map_setup()
	make_player()
end

function _update()
	move_player()
end

function _draw()
	cls()
	draw_map()
	draw_player()
end
-->8
--map code

function map_setup()
	--map tile settings
	wall=0
	key=1
	door=2
	anim1=3
	anim2=4
	lose=6
	win=7
end

function draw_map()
	map(0,0,0,0,64,128)
end

function is_tile(tile_type,x,y)
	tile=mget(x,y) --map get
	has_flag=fget(tile,tile_type) --flag get
	return has_flag
end

function can_move(x,y)
	return not is_tile(wall,x,y)
end
-->8
--player code

function make_player()
	p={}
	p.x=3
	p.y=2
	p.sprite=2
	p.keys=0
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end

function move_player()
	newx=p.x
	newy=p.y
	
	if (btnp(⬅️)) newx-=1
	if (btnp(➡️)) newx+=1
	if (btnp(⬆️)) newy-=1
	if (btnp(⬇️)) newy+=1

	if (can_move(newx,newy)) then
		p.x=mid(0,newx,63) --constrain
		p.y=mid(0,newy,127)
	else
		sfx(0)
	end
end
__gfx__
00000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666660007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700666666560007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000666666660007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000666666660007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700656666660007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666660007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666665555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666665666566600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666566665555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666566656665600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666665555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666656666665666566600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666665555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666666656665600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddddd2dddddddddd2dddd000ddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddddddddddddddddddddddddd05220dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddddddd2ddddd2dddddd05520dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddddddddddddddddddddddddd055520d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddddddddd2ddddddddddd2dddd05550d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddddddddd2ddddddddddd0000dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000100000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
2020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202023202020202020222023202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020222120202012121220202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020201210101112202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020232020201210101012202021202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020201201101012202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202012101220222020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020112020202020232000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202022202020102020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020012020202023202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202320202020102020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020201212101212202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021202020121010100110122020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020120110111010122020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020121010101011122020212000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020231212121212202023202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202220202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202021202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000c0700c0400c0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000