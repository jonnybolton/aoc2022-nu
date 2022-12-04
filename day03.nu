def main [filepath] {
    let data = ( open $filepath | lines | each { split chars } )
    let suitcases = ( $data | each { each { |c| get_item_priority $c } } )
    $suitcases | each { |case| get_common_item ( bisect_list $case ) } | math sum
    $suitcases | group 3 | each { |group| get_common_item $group } | math sum
}

def bisect_list [l] {
    let half_length = ( ( $l | length ) / 2 )
    $l | group $half_length
}

def get_common_item [lists] {
    $lists | reduce { |l, acc|
        $acc | each { |c| $l | find $c } | flatten | uniq
    } | first
}

def get_item_priority [item] {
    let ascii = ( $item | into binary | into int )
    if $ascii < 91 { $ascii - 38 } else { $ascii - 96 }
}
