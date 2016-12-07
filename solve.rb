GC.disable
$field = $<.map(&:chomp)
height = $field[0].size
width = $field.size

def dfs(y, x)
  if $field[y+1][x] == ' '
    $field[y+1][x] = ':'
    dfs(y+1, x)
    $field[y+1][x] = ' '
  end

  if $field[y][x-1] == ' '
    $field[y][x-1] = ':'
    dfs(y, x-1)
    $field[y][x-1] = ' '
  end

  if $field[y-1][x] == ' '
    $field[y-1][x] = ':'
    dfs(y-1, x)
    $field[y-1][x] = ' '
  end

  if $field[y][x+1] == 'G'
    puts $field
    exit(0)
  end

  if $field[y][x+1] == ' '
    $field[y][x+1] = ':'
    dfs(y, x+1)
    $field[y][x+1] = ' '
  end
end

height.times do |y|
  width.times do |x|
    if $field[y][x] == 'S'
      dfs(y,x)
    end
  end
end
