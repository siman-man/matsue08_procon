require 'pp'

class MazeGenerator
  MIN_N = 5
  MAX_N = 50

  DY = [0, 1, 0, -1]
  DX = [1, 0, -1, 0]

  def self.generate(seed = 0)
    new.run(seed)
  end

  def run(seed)
    init(seed)
    generate_wall(seed)

    until complete?
      break_wall
      update_field
    end

    STDERR.puts "N = #{@n}"

    show_field
  end

  def init(seed)
    rnd = Random.new(seed)
    @n = 2*(rnd.rand(MAX_N - MIN_N) + MIN_N) + 1
    @field = Array.new(@n){ Array.new(@n) }

    @startY = 2*rnd.rand(@n/2) + 1
    @startX = 0
    @goalY = 2*rnd.rand(@n/2) + 1
    @goalX = @n-1

    id = 0

    @n.times do |y|
      @n.times do |x|
        if y == 0 || y == @n-1 || x == 0 || x == @n-1 || (y.even? || x.even?)
          @field[y][x] = '#'
        else
          @field[y][x] = id
          id += 1
        end
      end
    end

    @field[@startY][@startX] = 'S'
    @field[@goalY][@goalX] = 'G'
  end

  def generate_wall(seed)
    rnd = Random.new(seed)
    @wall = Array.new(@n){ Array.new(@n){ Array.new(4, false) }}
    @remain_walls = []

    @n.times do |y|
      @n.times do |x|
        next if y == 0 || y == @n-1 || x == 0 || x == @n-1 || @field[y][x] == '#'

        2.times do |i|
          ny = y + 2*DY[i]
          nx = x + 2*DX[i]
          next if ny <= 0 || ny >= @n-1 || nx <= 0 || nx >= @n-1

          @remain_walls << [y, x, i]
        end
      end
    end

    @remain_walls.shuffle!(random: rnd)

    STDERR.puts "wall count = #{@remain_walls.size}"
  end

  def break_wall
    while @remain_walls.any?
      wall = @remain_walls.pop
      y, x, i = wall
      ny = y + 2*DY[i]
      nx = x + 2*DX[i]

      next if @field[y][x] == @field[ny][nx]
      @field[y+DY[i]][x+DX[i]] = ' '
      break
    end
  end

  def update_field
    @check_list = Array.new(@n){ Array.new(@n, false)}

    1.step(@n-1, 2) do |y|
      1.step(@n-1, 2) do |x|
        unless @check_list[y][x]
          dfs(y, x, @field[y][x])
        end
      end
    end
  end

  def dfs(y, x, id)
    @check_list[y][x] = true

    4.times do |i|
      ny = y + DY[i]
      nx = x + DX[i]

      next if ['S','G','#'].include?(@field[ny][nx]) || @check_list[ny][nx]
      @field[ny][nx] = id
      dfs(ny, nx, id)
    end
  end

  def complete?
    1.step(@n-1, 2) do |y|
      1.step(@n-1, 2) do |x|
        return false if @field[y][x] != 0
      end
    end

    true
  end

  def show_field
    @n.times do |y|
      @n.times do |x|
        if @field[y][x] == 0
          print ' '
        else
          print @field[y][x]
        end
      end

      puts
    end
  end
end

MazeGenerator.generate(10)
