require 'benchmark'
require_relative '../lib/sudo_priority_queue'
MaxPriority = 100
SampleSize = 100
LabelCharSize = 4
max_lbl = LabelCharSize.times.map {|i| 'z' }.join
mid_lbl = LabelCharSize.times.map {|i| 'm' }.join

prng = Random.new
labels = ('a'..max_lbl).map {|lbl| lbl }
items = labels.reduce([]) do |items, label|
  items << Item.new(label: label, priority: prng.rand(MaxPriority))
  items
end

puts "\nmax_lbl: #{max_lbl}\nSampleSize: #{SampleSize}"
puts "Items size: #{items.size}\n\n"
=begin
Benchmark.bmbm do |x|
  pq = PriorityQueue.new
  x.report("insert") do
    SampleSize.times do
      pq.clear
      items.each {|item| pq.insert(item.first, item.last) }
    end
  end
end
=end
pq = SudoPriorityQueue.new(items: items)
Benchmark.bmbm do |x|
  x.report("find_highest") { SampleSize.times do; pq.find_highest; end }

  x.report("find_lowest") { SampleSize.times do; pq.find_lowest; end }

  x.report("find_by_label - a") { SampleSize.times do; pq.find_by_label('a'); end }

  x.report("find_by_label - #{mid_lbl}") { SampleSize.times do; pq.find_by_label(mid_lbl); end }

  x.report("find_by_label - #{max_lbl}") { SampleSize.times do; pq.find_by_label(max_lbl); end }

  x.report("pull_highest") { SampleSize.times do; pq.pull_highest; end }

  x.report("pull_lowest") { SampleSize.times do; pq.pull_lowest; end }
end
