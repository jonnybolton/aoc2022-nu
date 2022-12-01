def main [filepath] {
    let data = ( open $filepath | lines | split list '' | each { into int } )
    part1 $data
    part2 $data
}

def part1 [data] {
    $data | each { math sum } | math max
}

def part2 [data] {
    $data | each { math sum } | sort -r | take 3 | math sum
}
