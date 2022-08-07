pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
table={1,2,3}
v1=2
v2=4

function is_in_table(t,_var)
		for var in all(t) do
				if var==_var then
						return true
				end
		end
		return false
end

print(is_in_table(table,v1))
print(is_in_table(table,v2))
