class Node
  attr_accessor :ypos, :xpos, :route

  def initialize(ypos: 0, xpos: 0, route: [])
    @ypos = ypos
    @xpos = xpos
    @route = route.dup
  end
end

class MazeSolver
  DY = [-1, 0, 1, 0]
  DX = [0, 1, 0, -1]

  def initialize(field)
    @field = field
    @height = @field[0].size
    @width = @field.size

    @height.times do |y|
      @width.times do |x|
        if @field[y][x] == 'S'
          @startY = y
          @startX = x
          break
        end
      end
    end
  end

  def run
    answer = solve

    answer.route.each do |y, x|
      @field[y][x] = ':'
    end

    @field
  end

  def solve
    que = []
    que.push(Node.new(ypos: @startY, xpos: @startX))
    check_list = Array.new(@height) { Array.new(@width, false) }

    while que.any?
      node = que.shift

      4.times do |i|
        ny = node.ypos + DY[i]
        nx = node.xpos + DX[i]

        next if check_list[ny][nx]
        check_list[ny][nx] = true

        return node if @field[ny][nx] == 'G'

        if @field[ny][nx] == ' '
          que.push(Node.new(ypos: ny, xpos: nx, route: node.route + [[ny, nx]]))
        end
      end
    end
  end
end

field = STDIN.each_line.map(&:chomp)
ms = MazeSolver.new(field)
puts(ms.run)
