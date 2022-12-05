def main [filepath] {
    let data = ( open $filepath | lines | each { split chars } )
    let suitcases = ( $data | each { each { get_item_priority } } )
    $suitcases | each { bisect_list | get_common_item } | math sum
    $suitcases | group 3 | each { get_common_item } | math sum
}

def bisect_list [] {
    group ( ( $in | length ) / 2 )
}

def get_common_item [] {
    reduce { |l, acc|
        $acc | each { |c| $l | find $c } | flatten | uniq
    } | first
}

def get_item_priority [] {
    let ascii = ( $in | into binary | into int )
    if $ascii < 91 { $ascii - 38 } else { $ascii - 96 }
}
