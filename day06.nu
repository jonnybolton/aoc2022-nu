def main [filepath] {
    let letters = ( open $filepath | split chars | drop )
    ( $letters | window 4 | each { uniq | length } | take until $it == 4 | length ) + 4
    ( $letters | window 14 | each { uniq | length } | take until $it == 14 | length ) + 14
}
