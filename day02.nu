let scores_part1 = {
    'A X':4 'A Y':8 'A Z':3
    'B X':1 'B Y':5 'B Z':9
    'C X':7 'C Y':2 'C Z':6
}

let scores_part2 = {
    'A X':3 'A Y':4 'A Z':8
    'B X':1 'B Y':5 'B Z':9
    'C X':2 'C Y':6 'C Z':7
}

def main [filepath] {
    let data = ( open $filepath | lines )
    total_score $data $scores_part1
    total_score $data $scores_part2
}

def total_score [data, score_lookup] {
    $data | each { |line| $score_lookup | get $line } | math sum
}
