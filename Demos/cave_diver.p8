pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
game_over=false
player={}

function _init()
	game_over=false
	player={}
	make_player()
	make_cave()
end

function _update()
	if game_over==false then
		update_cave()
		move_player()
		check_hit()
	else
		if btnp(5)==true then _init() end
	end
end

function _draw()
	cls()
	draw_cave()
	draw_player()
	
	if game_over==true then
		print("game over!",44,47)
		print("your score: "..player.score,34,54,7)
		print("press ❎ to play again!",18,64,6)
	else
		print("score: "..player.score,2,2,7)
	end
end
-->8
function make_player()
	player={}
	player.x=24
	player.y=60
	player.dy=0
	player.rise=1
	player.neutral=2
	player.fall=3
	player.dead=4
	player.speed=2
	player.score=0
end
	
-->8
function draw_player()
	if game_over==true then
		spr(player.dead,player.x,player.y)
	elseif (player.dy<1) and (player.dy>-1) then
		spr(player.neutral,player.x,player.y)
	elseif player.dy>=1 then
		spr(player.fall,player.x,player.y)
	else
		spr(player.rise,player.x,player.y)
	end
end

function move_player()
	gravity=0.2
	player.dy+=gravity
	//jump
	if (btnp(2)) then
		player.dy-=5
		sfx(0)
	end
	
	player.y+=player.dy
	
	//update score
	player.score+=player.speed
end
-->8
function make_cave()
	cave={{["top"]=5,["btm"]=119}}
	top=64-5
	btm=64+5
	
	function update_cave()
		if #cave>player.speed then
			for i=1,player.speed do
				del(cave,cave[1])
			end
		end
		
		while #cave<128 do
			local col={}
			local up=flr(rnd(7)-3)
			local down=flr(rnd(7)-3)
			col.top=mid(3,cave[#cave].top+up,top)
			col.btm=mid(btm,cave[#cave].btm+down,124)
			add(cave,col)
		end
	end
	
	function draw_cave()
		top_color=5
		btm_color=5
		for i=1,#cave do
			line(i-1,0,i-1,cave[i].top,top_color)
			line(i-1,127,i-1,cave[i].btm,btm_color)
		end
	end
end
-->8
function check_hit()
	for i=player.x,player.x+7 do
		if (cave[i+1].top>player.y)
		or (cave[i+1].btm<player.y+1) then
			game_over=true
			sfx(1)
		end
	end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000077700000000007770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000077777700777777007777770044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000077700000777777000007770044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000805009050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a00001f0500000015050000000d050000000505005050050500505005050050500505005050050500505000000000000000000000000000000000000000000000000000000000000000000000000000000000
