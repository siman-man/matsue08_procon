class MazeSolver
  DY = [1, 0, -1, 0]
  DX = [0, -1, 0, 1]

  def initialize(field)
    @field = field
    @height = @field[0].size
    @width = @field.size

    @height.times do |y|
      @width.times do |x|
        if @field[y][x] == 'S'
          @startY = y
          @startX = x
        elsif @field[y][x] == 'G'
          @goalY = y
          @goalX = x
        end
      end
    end
  end

  def run
    dfs(@startY, @startX)
  end

  def dfs(y, x)
    4.times do |i|
      ny = y + DY[i]
      nx = x + DX[i]

      if ny == @goalY && nx == @goalX
        puts @field
        exit
      end

      if @field[ny][nx] == ' '
        @field[ny][nx] = ':'
        dfs(ny, nx)
        @field[ny][nx] = ' '
      end
    end
  end
end

field = STDIN.each_line.map(&:chomp)
ms = MazeSolver.new(field)
ms.run
