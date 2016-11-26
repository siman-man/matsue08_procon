class PriorityQueue
  def initialize
    @nodes = []
  end

  def any?
    @nodes.any?
  end

  def push(node)
    @nodes << node
  end

  def pop
    @nodes.sort!
    @nodes.pop
  end
end

class Node
  attr_accessor :value, :ypos, :xpos, :route

  def initialize(ypos: 0, xpos: 0, value: 0, route: [])
    @value = value
    @ypos = ypos
    @xpos = xpos
    @route = route.dup
  end

  def <=>(other)
    other.value - value
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
        elsif @field[y][x] == 'G'
          @goalY = y
          @goalX = x
        end
      end
    end
  end

  def run
    node = solve

    ypos = @startY
    xpos = @startX

    node.route.each do |i|
      ypos += DY[i]
      xpos += DX[i]

      @field[ypos][xpos] = ':'
    end

    @field
  end

  def solve
    pque = PriorityQueue.new
    root = Node.new(ypos: @startY, xpos: @startX)
    pque.push(root)
    check_list = Array.new(@height) { Array.new(@width, false) }

    while pque.any?
      node = pque.pop

      4.times do |i|
        ny = node.ypos + DY[i]
        nx = node.xpos + DX[i]

        next if check_list[ny][nx]
        check_list[ny][nx] = true

        return node if ny == @goalY && nx == @goalX

        if @field[ny][nx] == ' '
          value = (@goalY - ny).abs + (@goalX - nx).abs
          pque.push(Node.new(ypos: ny, xpos: nx, value: value, route: node.route + [i]))
        end
      end
    end
  end
end

field = STDIN.each_line.map(&:chomp)
ms = MazeSolver.new(field)
#puts(ms.run)
