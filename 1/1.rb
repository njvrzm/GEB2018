strings = ["MI"]

add_u = lambda do |str|
  [str + "U"]
end

mx_to_mxx = lambda do |str|
  match = str.match(/^M(.*)$/)
  if match
    [str + match[1]]
  else
    []
  end
end

iii_to_u = lambda do |str|
  str.to_enum(:scan, /(?=(III))/) \
  .map{Regexp.last_match} \
  .map do |match|
    r = str.dup
    a,b = match.offset(1)
    r[(a...b)] = "U"
    r
  end
end

drop_uu = lambda do |str|
  str.to_enum(:scan, /(?=(UU))/) \
  .map{Regexp.last_match} \
  .map do |match|
    r = str.dup
    a,b = match.offset(1)
    r[(a...b)] = ""
    r
  end
end


rules = [add_u, mx_to_mxx, iii_to_u, drop_uu]

already_printed = {}

until strings.index("MU")
  strings = strings.map do |str|
    rules.map do |rule|
      rule[str]
    end
  end.flatten.uniq
  strings.each do |s|
    unless already_printed[s]
      already_printed[s] = true
      puts s
    end
  end
end

