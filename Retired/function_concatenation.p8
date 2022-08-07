pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
obj={
  f=function(self)
    self:_f()
    print("function completed")
  end,
  
  _f=function()
  end
}

function _init()
  local tempf=function()
    print("appended lines")
  end
  obj._f=compose(tempf,obj._f)
end

function _draw()
  cls()
  obj:f()
end

function func1()
  print("function 1",10,10)
end

function func2()
  print("function 2",10,20)
end

function func3()
  print("function 3",10,30)
end

function compose(f1, f2)
  return function(...) return f1(f2(...)) end
end

