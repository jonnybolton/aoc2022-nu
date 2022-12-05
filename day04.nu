def main [filepath] {
    let data = ( open $filepath | lines | parse '{a1}-{a2},{b1}-{b2}' | into int a1 a2 b1 b2 )
    $data | where { |row| ranges_completely_overlap $row } | length
    $data | where { |row| ranges_overlap_at_all $row } | length
}

def ranges_completely_overlap [r] {
    $r.a1 >= $r.b1 && $r.a2 <= $r.b2 || $r.b1 >= $r.a1 && $r.b2 <= $r.a2
}

def ranges_overlap_at_all [r] {
    $r.a2 >= $r.b1 && $r.b2 >= $r.a1
}
