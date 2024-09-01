
  do ->

    { Num, List, Str } = dependency 'primitive.Type'
    { string-from-code-point, camel-case, control-chars } = dependency 'native.String'

    unicode = -> 0x2500 + Num it

    solid-lines = <[
      light-horizontal heavy-horizontal
      light-vertical heavy-vertical
    ]>

    dashed-lines1 = <[
      light-triple-dash-horizontal heavy-triple-dash-horizontal
      light-triple-dash-vertical heavy-triple-dash-vertical
      light-quadruple-dash-horizontal heavy-quadruple-dash-horizontal
      heavy-quadruple-dash-vertical heavy-quadruple-dash-vertical
    ]>

    line-components1 = <[
      light-down-and-right down-light-and-right-heavy down-heavy-and-right-light heavy-down-and-right
      light-down-and-left  down-light-and-left-heavy  down-heavy-and-left-light  heavy-down-and-left

      light-up-and-right                   up-light-and-right-heavy  up-heavy-and-right-light
      heavy-up-and-right light-up-and-left up-light-and-left-heavy   up-heavy-and-left-light
                         heavy-up-and-left

      light-vertical-and-right vertical-light-and-right-heavy up-heavy-and-right-down-light down-heavy-and-right-up-light vertical-heavy-and-right-light down-light-and-right-up-heavy up-light-and-right-down-heavy heavy-vertical-and-right
      light-vertical-and-left  vertical-light-and-left-heavy  up-heavy-and-left-down-light  down-heavy-and-left-up-light  vertical-heavy-and-left-light  down-light-and-left-up-heavy  up-light-and-left-down-heavy  heavy-vertical-and-left

      light-down-and-horizontal left-heavy-and-right-down-light right-heavy-and-left-down down-light-and-horizontal-heavy down-heavy-and-horizontal-light right-light-and-left-down-heavy left-light-and-right-down-heavy heavy-down-and-horizontal
      light-up-and-horizontal   left-heavy-and-right-up-light   right-heavy-and-left-up     up-light-and-horizontal-heavy   up-heavy-and-horizontal-light right-light-and-left-up-heavy   left-light-and-right-up-heavy   heavy-up-and-horizontal

      light-vertical-and-horizontal left-heavy-and-right-vertical-light right-heavy-and-left-vertical-light
      vertical-light-and-horizontal-heavy up-heavy-and-down-horizontal-light down-heavy-and-up-horizontal-light
      vertical-heavy-and-horizontal-light left-up-heavy-and-right-down-light

      right-up-heavy-and-left-down-light
      left-down-heavy-and-right-up-light

      right-down-heavy-and-left-up-light
      right-down-heavy-and-left-up-light

      down-light-and-up-horizontal-heavy
      right-light-and-left-vertical-heavy left-light-and-right-vertical-heavy
      heavy-vertical-and-horizontal
    ]>

    dashed-lines2 = <[
      light-double-dash-horizontal heavy-double-dash-horizontal
      light-double-dash-vertical   heavy-double-dash-vertical
    ]>

    double-lines = <[
      double-horizontal
      double-vertical
    ]>

    line-components2 = <[
      down-single-and-right-double down-double-and-right-single double-down-and-right
      down-single-and-left-double  down-double-and-left-single  double-down-and-left

      up-single-and-right-double up-double-and-right-single double-up-and-right
      up-single-and-left-double  up-double-and-left-single  double-up-and-left

      vertical-single-and-right-double vertical-double-and-right-single double-vertical-and-right
      vertical-single-and-left-double  vertical-double-and-left-single  double-vertical-and-left

      down-single-and-horizontal-double down-double-and-horizontal-single double-down-and-horizontal
        up-single-and-horizontal-double   up-double-and-horizontal-single double-up-and-horizontal

      vertical-single-and-horizontal-double
      vertical-double-and-horizontal-single

      double-vertical-and-horizontal

    ]>

    arcs = <[
      light-arc-down-and-right
      light-arc-down-and-left

      light-arc-up-and-left
      light-arc-up-and-right
    ]>

    diagonals = <[
      light-diagonal-upper-right-to-lower-left
      light-diagonal-upper-left-to-lower-right

      light-diagonal-cross
    ]>

    half-lines = <[
      light-left
      light-up
      light-right
      light-down

      heavy-left
      heavy-up
      heavy-right
      heavy-down
    ]>

    mixed-lines = <[
      light-left-and-heavy-right light-up-and-heavy-down
      heavy-left-and-light-right heavy-up-and-light-down
    ]>

    upper-blocks = <[
      half
    ]>

    lower-blocks = <[
      one-eight one-quarter three-eights half
      five-eights three-quarters seven-eights
    ]>

    full-blocks = <[
      block
    ]>

    left-blocks = <[
      seven-eights three-quarters five-eights half
      three-eights one-quarter one-eight
    ]>

    right-blocks = <[
      half
    ]>

    shade-blocks = <[
      light medium dark
    ]>

    eighth-blocks = <[
      upper right
    ]>

    quadrant-blocks = <[
      lower-left lower-right
      upper-left
      upper-left-and-lower-left-and-lower-right upper-left-and-lower-right
      upper-left-and-upper-right-and-lower-left
      upper-left-and-upper-right-and-lower-right
      upper-right upper-right-and-lower-left
      upper-right-and-lower-left-and-lower-right
    ]>

    #

    chars = (offset, names, prefix = '', suffix = '') -> { [ (camel-case "#prefix#name#suffix"), (string-from-code-point unicode index + offset) ] for name, index in names }

    #

    offset = 0

    inc = !-> offset := offset + it.length

    #

    solid-line-chars = chars offset, solid-lines ; inc solid-lines

    dashed-line-chars1 = chars offset, dashed-lines1 ; inc dashed-lines1

    line-component-chars1 = chars offset, line-components1 ; inc line-components1

    dashed-line-chars2 = chars offset, dashed-lines2 ; inc dashed-lines2

    double-line-chars = chars offset, double-lines, 'double' ; inc double-lines

    line-component-chars2 = chars offset, line-components2 ; inc line-components2

    arc-chars = chars offset, arcs ; inc arcs

    diagonal-chars = chars offset, diagonals ; inc diagonals

    half-line-chars = chars offset, half-lines ; inc half-lines

    mixed-line-chars = chars offset, mixed-lines ; inc mixed-lines

    upper-chars = chars offset, upper-blocks, 'upper-' ; inc upper-blocks

    lower-chars = chars offset, lower-blocks, 'lower-' ; inc lower-blocks

    full-chars = chars offset, full-blocks, 'full-' ; inc full-blocks

    left-chars = chars offset, left-blocks, 'left-' ; inc left-blocks

    right-chars = chars offset, right-blocks, 'right-' ; inc right-blocks

    shade-chars = chars offset, shade-blocks, 'shade-' ; inc shade-blocks

    eighth-chars = chars offset, eighth-blocks,, '-one-eight' ; inc eighth-blocks

    quadrant-chars = chars offset, quadrant-blocks, 'quadrant-'

    #

    dashed-line-chars = {} <<< dashed-line-chars1 <<< dashed-line-chars2

    line-component-chars = {} <<< line-component-chars1 <<< line-component-chars2

    #

    box-drawing-chars = {} <<< solid-line-chars <<< dashed-line-chars <<< line-component-chars <<< double-line-chars
    box-drawing-chars <<< arc-chars <<< diagonal-chars <<< half-line-chars <<< mixed-line-chars
    box-drawing-chars <<< upper-chars <<< lower-chars <<< full-chars <<< left-chars <<< right-chars <<< eighth-chars
    box-drawing-chars <<< quadrant-chars

    #

    { sp: empty-block } = control-chars
    { full-block } = box-drawing-chars

    box-drawing-chars <<< { empty-block }

    {
      solid-line-chars, dashed-line-chars, line-component-chars, double-line-chars, arc-chars, diagonal-chars, half-line-chars, mixed-line-chars, quadrant-chars
      box-drawing-chars
    }
