pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
--init
function _init()
		--gui init
		pause_menu:init()
  --global vars
  items={}
  gamestate="run"
  
  --mouse
  mouse:init()

		--init subclasses
		init_menus()
		init_item_types()
		init_subclasses()
		init_loot_tables()

		create_wand(40,64)
		create_potion(50,64)
		create_book(60,64)
		
		create_wand(40,75,fire,gold)
		create_potion(50,75,{lv=2,uses=1},
		              mana,elven)
		create_potion(60,75,2,mana,glass)
		create_book(70,75,4,
		  {
		    t1=fire,
		    t2=earth,
		    t3=water,
		    t4=air
		  })

		for _,item in pairs(items) do
		  item:init()
		end
end
-->8
--update
function _update()
  mouse:update()
  
  //menu interrupts
  if btnp(5) then
    if gamestate=="pause" then
      gamestate="run"
      pause_menu.selected=1
    else
      gamestate="pause"
    end
  end
  
  //game loop
  if gamestate=="pause" then
    pause_menu:input()
  elseif gamestate=="inv" then
    inv:input()
  elseif gamestate=="run" then
  end
end
-->8
--draw
function _draw()
	cls()
	
	for _,item in pairs(items) do
	  item:draw()
	end
	
	print(item_table.sum,2,2,5)
	
	if gamestate=="pause" then
	  pause_menu:draw()
	elseif gamestate=="inv" then
	  inv:draw()
	end
	
	local c=7
	if(mouse.state==1)c=5
	if(mouse.state==2)c=13
	pset(mouse.x,mouse.y,c)
end
-->8
--item class
game_item={
	x=64,y=64,
	sprite=0,
	
	draw=function(self)
			spr(self.sprite,
			    self.x,self.y)
	end
}

function init_proc_item()
  proc_item=copy(game_item)
  proc_item.base_colors={
    c0=7,c1=4,c2=11,c3=2,c4=9
  }
		proc_item.colors={}
		function proc_item:draw()
			//palette swaps
			for id,c in pairs(self.colors) do
			  pal(self.base_colors[id],c)
			end
			//draw sprite
			spr(self.sprite,
			self.x,self.y)
			//reset palette
			pal()
		end
		
		function proc_item:init()end
end
-->8
--item subclasses
--wand
function init_subclasses()
		init_proc_item()
		init_wand()
		init_potion()
		init_book()
end

function init_wand()
	 wand=copy(proc_item)
	 wand.type=wood
	 wand.magic_type=air
	 function wand:init()
	   self.colors={
	     c0=self.type.c,
	     c1=self.magic_type.c
	   }
	 end
	 wand:init()
end

function init_potion()
  potion=copy(proc_item)
  potion.sprite=2
  potion.level=1
  potion.uses=1
  potion.type=health
  potion.container_type=glass
  function potion:init()
  		self.sprite=self.level+self.uses
    self.colors={
      c0=self.container_type.c,
      c1=self.type.c
    }
  end
  
  function potion:use()
    self.uses-=1
    if self.uses==0 then
      self.sprite=0
    else
      self.sprite=self.level+self.uses
    end
  end
  potion:init()
end

function init_book()
  book=copy(proc_item)
  book.sprite=19
  book.level=1
  book.types={
    t1=air,
    t2=air,
    t3=air,
    t4=air
  }
  function book:init()
    //set sprite
  		self.sprite=15+self.level
  		//set colors
  		self.colors={
      c0=6,
      c1=self.types.t1.c,
      c2=self.types.t2.c,
      c3=self.types.t3.c,
      c4=self.types.t4.c
    }
  end
  book:init()
end
-->8
--item type classes
function init_item_types()
		init_wand_types()
		init_magic_types()
		init_potion_types()
		init_materials()
end

magic_type={
  name="air",
  c=12}

wand_type={
  name="wood",
  c=5}
  
potion_type={
  name="health",
  c=8}

material = {
  name="glass",
  c=6}

function init_magic_types()
		//air
		air=copy(magic_type)
  //fire
  fire=copy(magic_type)
  fire.name="fire"
  fire.c=8
  
  //earth
  earth=copy(magic_type)
  earth.name="earth"
  earth.c=3
  
  //water
  water=copy(magic_type)
  water.name="water"
  water.c=1
end

function init_wand_types()
  wood=copy(wand_type)
  
  ivory=copy(wand_type)
  ivory.name="ivory"
  ivory.c=6
  
  gold=copy(wand_type)
  gold.name="gold"
  gold.c=10
end

function init_potion_types()
  health=copy(potion_type)
  
  mana=copy(potion_type)
  mana.name="mana"
  mana.c=12
end

function init_materials()
		glass=copy(material)
		
		elven=copy(material)
		elven.name="elven"
		elven.c=13
end
-->8
--functions
function copy(o)
  local c
  if type(o) == 'table' then
    c = {}
    for k, v in pairs(o) do
      c[k] = copy(v)
    end
  else
    c = o
  end
  return c
end

function longest_string(_t)
		local _len=0
		local _l
  for _,entry in pairs(_t) do
    _l=#entry
    if _l>_len then
      _len=_l
    end
  end
  return _len
end
-->8
--top-level spawning functions

function create_potion(_x,_y,_lv,_type,_c_type)
  local temp=copy(potion)
		if(_x)temp.x=_x
		if(_y)temp.y=_y
		if type(_lv)=="table" then
		  temp.level=_lv.lv
		  temp.uses=_lv.uses
		elseif _lv then
		  temp.level=_lv
		  temp.uses=_lv
		end
		if(_type)temp.type=_type
		if(_c_type)temp.container_type=_c_type
		add(items,temp)
end

function create_wand(_x,_y,_m_type,_type)
  local	temp=copy(wand)
		if(_x)temp.x=_x
		if(_y)temp.y=_y
		if(_type)temp.type=_type
		if(_magic_type)temp.magic_type=_m_type
		add(items,temp)
end

function create_book(_x,_y,_lv,_types)
  local temp=copy(book)
  if(_x)temp.x=_x 
  if(_y)temp.y=_y
		if(_lv)temp.level=_lv
		//assign types from _types
		if _types then
		  for id,_t in pairs(_types) do
			   temp.types[id]=_t
		  end
		end
		add(items,temp)
end
-->8
-- loot tables

function init_loot_tables()
   init_loot_table()
end

item_table={
		wand={weight=25},
		book={weight=25},
		potion={weight=50}
}

function init_loot_table()
  local _id=0
  //goes through the table
  //in  random order
  for _,entry in pairs(item_table) do
    entry.id=_id
    _id+=entry.weight
  end
  item_table.sum=_id
end

function gen_item(_t)
  local _r = flr(rnd(_t.sum))
  for name,entry in pairs(item_table) do
    if entry.id<=_r and
       _r<entry.id+entry.weight then
      return name
    end
  end
end
-->8
--mouse
mouse = {
  x=64,y=64,
  state=0,
  init = function()
    poke(0x5f2d, 1)
  end,
  update = function(self)
    self.x=stat(32)-1
    self.y=stat(33)-1
    self.state=stat(34)
  end,
  -- 0 = no button
  -- 1 = left
  -- 2 = right
}
-->8
--menu drawing functions
function init_menus()
  init_inventory()
end

function init_inventory()
  inv=copy(pause_menu)
  inv.contents={
    "resume",
    "item1",
    "item2",
    "resume"
  }
  inv:init()
end

pause_menu={
  x=64,y=64,
  maxchars=0,
  entries=0,
  selected=1,
  contents={
		  [1]="resume",
		  [2]="inventory",
		  [3]="exit"
		},
		
		resume=function(self)
		  gamestate="run"
		  pause_menu.selected=1
		end,
		
		inventory=function(self)
		  gamestate="inv"
		end,
		exit=function(self)
		  stop()
		end,
		
		init=function(self)
		  self.maxchars=longest_string(self.contents)
		  self.entries=#self.contents
		end,
		
		input=function(self)
		  if btnp(2) then
		    self.selected=max(self.selected-1,1) 
		  end
		  if btnp(3) then
		    self.selected=min(self.selected+1,self.entries)
		  end
		  if btnp(4) then
		    if gamestate=="pause" then
		      self[self.contents[self.selected]]()
		    elseif gamestate=="inv" then
		      if self.contents[self.selected]=="resume" then
		        self:resume()
		      else
		        //selected an item
		        self:resume()
		      end
		    end
		  end
		end,
		
		draw=function(self)
	   drawmenu(self.x,self.y,
	            self.contents,
	            self.maxchars,
	            self.selected)
		end
}

function drawmenu(_x,_y,_entries,_chars,_selected)
  local o_x=_y-flr((6+_chars*4)/2)
  local o_y=_x-flr((5+#_entries*7)/2)
  rectfill(o_x-2,o_y-2,o_x+4+_chars*4,o_y+#_entries*8+2,5)
  rect(o_x-2,o_y-2,o_x+4+_chars*4,o_y+#_entries*8+2,7)
  i=0
  for entry in all(_entries) do
    local t_x=2+o_x
    local t_y=2+i*8+o_y
    print(entry,t_x,t_y,7)
    if (i+1)==_selected then
      drawselected(t_x,t_y,#entry)
    end
    i+=1
  end
end

function drawselected(_x,_y,_chars)
  rect(_x-2,_y-2,_x+4*_chars,_y+6,7)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000bb00000900000009000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00004400000044b00077977000779770007797700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007400000074000007470000070700000747000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070000000700000007470000070700000747000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700000007000000007470000744470007444700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07000000070000000000700000077700000777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0044444000444bb0004bb2200044bbb0007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00447440004747b0007b727000747b70007557000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00447440004747b0007b727000747b70007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
004474400047b7b000747b7000727970007577000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
004474400047b7b000747b7000729790007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
004444400044bbb00044bb2000229990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
