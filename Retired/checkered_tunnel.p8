pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
cls()
t=0
i=0
s=2
::f::
		for x=-64,63,s do
		for y=-64,63,s do

				o_x=flr(x+i%s)
				o_y=flr(y+i/s)
				
				a=atan2(o_x,o_y)
				r=sqrt(o_x*o_x+o_y*o_y)
				
				_x=flr(a*3*4)
				_y=flr(t/20+32/r)
				
				//checkerboard pattern
				g=0if(_x%2==_y%2)g=1
				//distance fade
				if(r<4)g=0

				pset(o_x+64,o_y+64,g)
		end end flip()
		t+=1
		i+=1 
		i%=(s*s)
goto f
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000