require 'benchmark'
require_relative '../lib/sudo_priority_queue'
require_relative '../lib/item'

PQvariant = 'SudoPriorityQueue'
PQsizes = [100, 1000, 10000, 100000, 1000000]
MaxPriority = 100
SampleSize = 100

labels = ('a'..'zzzzz').map {|lbl| lbl }

prng = Random.new
items = PQsizes.last.times.map do |i|
  Item.new(label: labels[i], priority: prng.rand(MaxPriority))
end

puts "Priority Queue Variant: #{PQvariant}"

pq = SudoPriorityQueue.new
PQsizes.each do |qsize|
  puts "\n"
  puts "Queue size: #{qsize}"
  puts "SampleSize: #{SampleSize}"
  puts "Max Label: '#{labels[qsize-1]}'"

  3.times do |_|
    pq.clear
    qsize.times {|i| pq.insert(items[i]) }
    Benchmark.bmbm do |x|
      x.report("find_highest") { SampleSize.times do; pq.find_highest; end }
      x.report("pull_highest") { SampleSize.times do; pq.pull_highest; end }
    end
    puts "\n"
  end
end
