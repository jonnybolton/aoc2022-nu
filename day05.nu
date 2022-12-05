def main [filepath] {
    let data = ( open $filepath | parse_input )
    apply_all_instructions_cm9000 $data | get_top_elements | reduce { |a,b| $b + $a }
    apply_all_instructions_cm9001 $data | get_top_elements | reduce { |a,b| $b + $a }
}

def parse_input [] {
    let data = $in
    let split_index = ( $data | str index-of "\n\n" )
    let state = ( $data | str substring ..$split_index | parse_state )
    let instructions = ( $data | str substring ( $split_index + 2 ).. | parse_instructions )
    { state: $state, instructions: $instructions }
}

def parse_state [] {
    let crate_rows = ( $in | lines | drop 1 | each { split chars | group 4 | each { get 1 } } )
    def get_nth_elem_in_row [index] { $crate_rows | each { get $index } | reverse | take while { |c| $c != ' ' } }
    0..8 | reduce -f [[]] { |it, acc| $acc | append [ ( get_nth_elem_in_row $it ) ] }
}

def parse_instructions [] {
    lines | parse 'move {amount} from {source} to {destination}' | into int amount source destination
}

def apply_all_instructions_cm9000 [data] {
    $data.instructions | reduce -f $data.state { |instr, state| apply_instruction_cm9000 $instr $state }
}

def apply_instruction_cm9000 [instr, state] {
    if $instr.amount == 0 {
        $state
    } else {
        let val = ( $state | get $instr.source | last )
        let state = ( $state | update $instr.source ( $state | get $instr.source | drop ) )
        let state = ( $state | update $instr.destination ( $state | get $instr.destination | append $val ) )
        let instr = ( $instr | update amount ( $instr.amount - 1 ) )
        apply_instruction_cm9000 $instr $state
    }
}

def apply_all_instructions_cm9001 [data] {
    $data.instructions | reduce -f $data.state { |instr, state| apply_instruction_cm9001 $instr $state }
}

def apply_instruction_cm9001 [instr, state] {
    let moved_elements = ( $state | get $instr.source | last $instr.amount )
    let state = ( $state | update $instr.source ( $state | get $instr.source | drop $instr.amount ) )
    let state = ( $state | update $instr.destination ( $state | get $instr.destination | append $moved_elements ) )
    $state
}

def get_top_elements [] {
    let state = $in
    1..9 | each { |i| $state | get $i | last }
}
