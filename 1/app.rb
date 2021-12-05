input = "./input.txt"
measurements = []
count_increases = 0

File.open(input, "r").each_line do |line|
  measurements << line.to_i
end

measurements.each_with_index do |measure, i|
    if i > 0
        if measure > measurements[i - 1]
            count_increases += 1
        end
    end
end

puts count_increases