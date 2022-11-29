require 'pdf-reader'
require 'date'

files = Dir['./files/*']
results = []

def get_name(string)
    index = 0
    name = []
    while string[index] != 'Supreme'
        name.append(string[index])
        index+=1
    end
    return name.join(' ').split(',').join(',')
end

def get_date(string)
    arr = string.split("/")
    if arr[-1].length == 4
        date = DateTime.parse("%s/%s/%s" % [arr[1],arr[0],arr[2]])
    else
        date = DateTime.parse("%s/%s/20%s" % [arr[1],arr[0],arr[2]])
    end
    return date.strftime('%Y/%m/%d')
end

files.each { |file| 
    reader = PDF::Reader.new(file)
    reader.pages.each do |page|
        text = page.text
        if text.include? 'Judgment for Costs'
            s = text.split()
            state = s[6..8].join(' ')
            petitioner = get_name(s[9..])
            date = get_date(s[s.find_index('Notice:')+1])
            amount = s.select{|item| item.include?'$'}[0].split('.')[0]
            results.append({
                ":petitioner" => petitioner , 
                ":state" => state,
                ":amount"=> amount, 
                ":date" => date
            })
        end
    end
}

puts results
