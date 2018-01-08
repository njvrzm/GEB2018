strings = ["MI"]

add_u = lambda do |str|
  [str + "U"]
end

x_to_xx = lambda do |str|
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


rules = [add_u, x_to_xx, iii_to_u , drop_uu]

until strings.index("MU")
  strings = strings.map do |str|
    rules.map do |rule|
      rule[str]
    end
  end.flatten.uniq.sort
  p strings
  break
end

