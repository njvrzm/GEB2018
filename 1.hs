mi = "MI"

is_mu str = (str == "MU")

add_u str = [str ++ "U"]

mx_to_mxx ('M':str) = ['M':(str++str)]

iii_to_u ('I':'I':'I':rest) = ('U':rest) : ( map ('I':) (iii_to_u ('I':'I':rest) )
iii_to_u (ch:rest) = map (ch:) (iii_to_u rest)
iii_to_u "" = [""]

drop_uu ('U':'U':rest) = rest: (map ('U':) (drop_uu str))
drop_uu (ch:rest) = map (ch:) (drop_uu rest)
drop_uu "" = [""]

main = do return mi
