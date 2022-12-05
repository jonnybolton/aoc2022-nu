def main [filepath] {
    let elf_calories = ( open $filepath | lines | split list '' | each { into int | math sum } )
    $elf_calories | math max
    $elf_calories | sort -r | take 3 | math sum
}
