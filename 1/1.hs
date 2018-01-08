import Data.List

mi = "MI"

is_mu str = (str == "MU")

add_u str = [str ++ "U", str]

mx_to_mxx str@('M':rest) = ['M':(rest++rest), str]

shift_and_recur f (ch:rest) = map (ch:) (f rest)
shift_and_recur f [] = [[]]

iii_to_u str@('I':'I':'I':rest) = ('U':rest) : (shift_and_recur iii_to_u str)
iii_to_u str = shift_and_recur iii_to_u str

drop_uu str@('U':'U':rest) = rest : (shift_and_recur drop_uu str)
drop_uu str = shift_and_recur drop_uu str


apply_rules_to_theorem rules str = nub $ concatMap (\f -> f str) rules

all_theorums_from rules theorems = nub $ theorems ++ more_theorems ++ (all_theorums_from rules more_theorems)
  where more_theorems = concatMap (apply_rules_to_theorem rules) theorems

stop_at pred (x:rest) = if (pred x)
                          then [x]
                          else x:(stop_at pred rest)

main = do
  let start_with = [mi]
  let rules = [add_u, mx_to_mxx, iii_to_u, drop_uu]
  let destination = is_mu
  -- let destination = (=="MIIU") -- to test the win condition
  mapM_ putStrLn (stop_at destination $ all_theorums_from rules start_with)
