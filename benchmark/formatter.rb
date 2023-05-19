require 'csv'
require_relative 'parser'

parser = Parser.new
puts "\n"
p parser.rate_plotdata
puts "\n"
p parser.time_plotdata

rd = parser.rate_plotdata
td = parser.time_plotdata

File.open('sudo_pq.csv', 'w+') do |file|
  ['Find', 'Pull', 'Insert'].each do |mthd|
    output_string = "#{mthd}:, \nsize,rate\n"
    output_string << CSV.generate do |csv|
      rd[mthd.downcase].each {|pair| csv << pair }
    end
    output_string << " , \n , \n"
    file.write(output_string)
  end

  ['Find', 'Pull', 'Insert'].each do |mthd|
    output_string = "#{mthd}:, \nsize,time\n"
    output_string << CSV.generate do |csv|
      td[mthd.downcase].each {|pair| csv << pair }
    end
    output_string << " , \n , \n"
    file.write(output_string)
  end
end
