-- fstr - substitute placeholders in strings
-- copyright (c) 2025  Alex Rogers (https://github.com/linguisticmind)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

if #arg == 0 then
  io.stderr:write('fstr: fstr <str> [<name> <replacement> ...]\n')
  io.stderr:write('version: 0.1.1\n')
  os.exit(1)
end

str, replacements = arg[1], {}

for i = 2, #arg, 2 do replacements[arg[i]] =  arg[i + 1]:gsub('\\([\\%%:{}])', '%1') end

function string:fstr_match()

  local name, fallback, override

  i, j = self:find('^%%[%w_]+')
  if i == nil then i, j = self:find('[^\\]%%[%w_]+'); if i ~= nil then i = i + 1 end end

  if i ~= nil then name = self:sub(i + 1, j) else

    if i == nil then i, j = self:gsub('\\[{}]', '__'):find('^%%%b{}') end
    if i == nil then i, j = self:gsub('\\[{}]', '__'):find('[^\\]%%%b{}'); if i ~= nil then i = i + 1 end end
    
    if i == nil then return false end

    local rest
    name, rest = self:sub(i + 2, j - 1):match('([%w_]+)(.*)')

    repeat
      local split = rest:find('[^\\]:')
      if rest:sub(2, 2) == '-' then
        fallback = rest:sub(3, split or #rest)
      elseif rest:sub(2, 2) == '+' then
        override = rest:sub(3, split or #rest)
      end
      if split ~= nil then rest = rest:sub(split + 1) else rest = '' end
    until rest == ''

  end

  replacement = replacements[name] and override or replacements[name] or fallback

  if replacement ~= nil then return true else
    io.stderr:write('fstr: unable to replace %{' .. name .. '}\n')
    os.exit(1)
  end

end

while str:fstr_match() do
  str = str:sub(1, i - 1) .. replacement .. str:sub(j + 1)
end

str = str:gsub('\\([\\%%:{}])', '%1')

print(str)
