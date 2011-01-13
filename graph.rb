require 'csv'
require 'rubygems'
require 'gchart'

            
hash = Hash.new({})
title = "Autobench results"
legend = []
thickness = []
data = []

Dir["*.csv"].each do |out|
  test = out.split(".").first
  result = CSV.read(out)  
  header = result.shift
  
  values = []
  result.compact.each do |line|
    values << [line[2].to_f, line[4].to_f, line[6].to_f]
  end
  values = values.sort_by {|x,y,stddev| x}
  
  legend << test
  thickness << 1
  data << values.map {|x,y,stddev| x} << values.map {|x,y,stddev| y + rand * 5} 
end

url = Gchart.line_xy(:size => '700x400', :theme => :thirty7signals, :data => data, :title => title, :legend => legend, :axis_with_labels => 'x,y', :encoding => 'extended', :thickness => thickness.join("|")).to_s

puts url
system("open #{url.inspect}")
