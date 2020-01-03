BEGIN {
  split("Gold Silver Bronze", ranks)
  print "Available Ranks:"
  # for (i = 1; i <= 3; i++) {
  for (i = 1; i <= length(ranks); i++) {
    print ranks[i]
  }
  print "------"
}
NR < 4 {
  sum = 0
  for (i = 4; i <= 7; i++) {
    sum += $i
  }
  if (sum > 1000) {
    rank = ranks[1]
  } else if (sum > 800) {
    rank = ranks[2]
  } else {
    rank = ranks[3]
  }
  printf "Name: %-10s Sum: %'10d Rank: %-10s\n", $3, sum, rank
}
