pico-8 cartridge

__lua__
t=0i=0s=2::f::for x=-64,63,s do for y=-64,63,s do
j=flr(x+i%s)k=flr(y+i/s)a=atan2(j,k)r=sqrt(j*j+k*k)u=flr(a*3*4+t/30)v=flr(t/20+32/r)
g=0if(u%2==v%2)g=1
if(r<4)g=0
pset(j+64,k+64,g)end end t+=1i+=1i%=(s*s)goto f