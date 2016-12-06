require 'benchmark'

Benchmark.bm do |x|
  x.report do
    (1..10).each do |seed|
      system("ruby solve.rb < test_case/seed#{seed}.txt")
    end
  end
end
