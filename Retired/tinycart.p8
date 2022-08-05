pico-8 cartridge

__lua__
t=0::f::
t+=1for i=t%2,16384,2 do
x=i%128y=i/128pset(x,y,(x+y+t)/25)end
flip()goto f
