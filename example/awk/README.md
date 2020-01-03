# AWK入門

フィールドの選択
---
```
{
  # print $3, $4
  # print $3 ":" $4
  # print $0    すべて
  # print NF, $NF   Number of Field
  print NR ":" $0   Number of Record
}
```

初期化処理周り
---
```
# BEGIN {
#   print "--- START ---"
# }
# NR > 5 && NR < 10 {
#   print $0
# }
# END {
#   print "--- END ---"
# }

# BEGIN {
#   FS = "-"
# }
# NR > 5 && NR < 10 {
#   print $1, $2
# }

# BEGIN {
#   RS = ":"
# }
# NR == 1 {
#   print $0
# }

BEGIN {
  OFS = "@"
  ORS = "|"
}
NR > 5 && NR < 10 {
  print $3, $4
}
```

演算子
---
- 検算しやすいように、レコード番号が NR < 4 としておきます。
```
BEGIN {
  total = 0
}
NR < 4 {
  # + - * / % ^
  # ++ --
  # total = total + $4
  total += $4
}
END {
  print total
}
```

printf
---
```
NR > 96 {
  # print $3, ($4+$5+$6+$7), (($4+$5+$6+$7)/4)
  # printf "Name: %s Sum: %d Avg: %f\n", $3, ($4+$5+$6+$7), (($4+$5+$6+$7)/4)
  # printf "Name: %-10s Sum: %10d Avg: %010.2f\n", $3, ($4+$5+$6+$7), (($4+$5+$6+$7)/4)
  printf "Name: %-10s Sum: %'10d Avg: %010.2f\n", $3, ($4+$5+$6+$7), (($4+$5+$6+$7)/4)
}
```

組み込み関数
---
```
BEGIN {
  print int(3.8) # 3
  print length("hello") # 5
  print substr("hello", 3) # llo
  print substr("hello", 3, 2) # ll
}
```

if文
---
```
NR < 31 {
  print NR ":" $0
  if (NR % 10 == 0) {
    print "------"
  } else if (NR % 5 == 0) {
    print "---"
  } else {
    print "-"
  }
}
```

while文
---
- その sum に 4 番目のフィールドから 7 番目のフィールドを足し上げていけばいいので、何番目のフィールドを処理しているかを i で持っておくことにしましょう。

```
NR < 4 {
  sum = 0
  i = 4
  while (i <= 7) {
    sum += $i
    i++
  }
  printf "Name: %-10s Sum: %'10d\n", $3, sum
}
```

for , break , continue
---
```
NR < 4 {
  sum = 0
  for (i = 4; i <= 7; i++) {
    if ($i < 100) {
      # continue
      break
    }
    sum += $i
  }
  printf "Name: %-10s Sum: %'10d\n", $3, sum
}
```

配列を扱ってみる
---
- splitで定義しちゃうのが楽そう
```
BEGIN {
  # rank1 = "Gold"
  # rank2 = "Silver"
  # rank3 = "Bronze"
  # ranks[1] = "Gold"
  # ranks[2] = "Silver"
  # ranks[3] = "Bronze"
  split("Gold Silver Bronze", ranks)
  print ranks[1] # Gold
  ranks[2] = "Plata"
  print ranks[2] # Plata
  exit
}
NR < 4 {
  sum = 0
  for (i = 4; i <= 7; i++) {
    sum += $i
  }
  printf "Name: %-10s Sum: %'10d\n", $3, sum
}

```

配列をループで回す
---
- では今回 … Rank: %-10s\n" … で左揃えにしつつ 10 桁にしてあげましょう。
```
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
```
<details>
<summary>実行ログ</summary>

```
-> % awk -f myapp.awk score.dat                                                                       07:47:04 - 07:47:10
Available Ranks:
Gold
Silver
Bronze
------
Name: tanaka     Sum:        802 Rank: Silver    
Name: taguchi    Sum:        400 Rank: Bronze    
Name: fkoji      Sum:        796 Rank: Bronze    
```

</details>

関数を自前で作成する
---
- 前回の実装よりも見通しがよくなりました
```
NR < 4 {
  sum = getSum()
  rank = getRank(sum)
  printf "Name: %-10s Sum: %'10d Rank: %-10s\n", $3, sum, rank
}

function getSum() {
  sum = 0
  for (i = 4; i <= 7; i++) {
    sum += $i
  }
  return sum
}

function getRank(sum) {
  split("Gold Silver Bronze", ranks)
  if (sum > 1000) {
    rank = ranks[1]
  } else if (sum > 800) {
    rank = ranks[2]
  } else {
    rank = ranks[3]
  }
  return rank
}
```

連想配列を使ってみよう
---
- ランク定義がわかりやすくなる
- ユーザーごとの集計が楽になる
  - 集計処理をするときによく使われるテクニックなので、覚えておくといいでしょう。

```
# NR < 4 {
#   sum = getSum()
#   rank = getRank(sum)
#   printf "Name: %-10s Sum: %'10d Rank: %-10s\n", $3, sum, rank
# }
{
  sum = getSum()
  total[$3] += sum
  # total["taguchi"] += sum
  # total["fkoji"] += sum
}
END {
  for (name in total) {
    printf "Name: %-10s Total: %'10d\n", name, total[name]
  }
}

function getSum() {
  sum = 0
  for (i = 4; i <= 7; i++) {
    sum += $i
  }
  return sum
}

function getRank(sum) {
  # split("Gold Silver Bronze", ranks)
  ranks["first"] = "Gold"
  ranks["second"] = "Silver"
  ranks["third"] = "Bronze"
  if (sum > 1000) {
    rank = ranks["first"]
  } else if (sum > 800) {
    rank = ranks["second"]
  } else {
    rank = ranks["third"]
  }
  return rank
}

```

グラフを描いてみよう
---
- 上のとあんまり変わってない。出力結果に******が出るようになった。（グラフとは遠い気もしますが；；）
```
{
  sum = getSum()
  total[$3] += sum
}
END {
  for (name in total) {
    printf "Name: %-10s Total: %'10d %s\n", name, total[name], getBarGraph(total[name])
  }
}

function getBarGraph(total) {
  s = ""
  for (i = 1; i <= int(total / 1000); i++) {
    s = s "*"
  }
  return s
}

function getSum() {
  sum = 0
  for (i = 4; i <= 7; i++) {
    sum += $i
  }
  return sum
}

function getRank(sum) {
  # split("Gold Silver Bronze", ranks)
  ranks["first"] = "Gold"
  ranks["second"] = "Silver"
  ranks["third"] = "Bronze"
  if (sum > 1000) {
    rank = ranks["first"]
  } else if (sum > 800) {
    rank = ranks["second"]
  } else {
    rank = ranks["third"]
  }
  return rank
}
```
