
  do ->

    { string-from-code-point, camel-case } = dependency 'native.String'
    { Num } = dependency 'primitive.Type'

    unicode = -> 0x1ce00 + Num it

    #

    offset = 26

    large-type-pieces-names = <[ upper-left-arc upper-left-corner upper-terminal upper-left-crotch left-arm
      crossbar crossbar-with-lower-stem upper-half-vertex-of-m diagonal-lower-left short-upper-terminal
      upper-right-arc right-arm upper-right-crotch upper-right-corner stem-with-right-crossbar
      stem diagonal-upper-right-and-lower-right diagonal-upper-right diagonal-lower-right
      short-lower-terminal lower-left-and-upper-left-arc centre-of-k lower-half-vertex-of-m
      upper-half-vertex-of-w centre-of-x centre-of-y centre-of-z-with-crossbar raised-upper-left-arc
      stem-with-left-crossbar lower-right-and-upper-right-arc diagonal-upper-left-and-lower-left
      stem-with-left-joint stem-with-crossbar diagonal-upper-left lower-terminal lower-left-corner
      lower-left-arc lower-left-crotch crossbar-with-upper-stem vertex-of-v lower-half-vertex-of-w
      lower-right-arc lower-right-corner lower-right-arc-with-tail lower-right-crotch
      stem-45 stem-2345 stem-4 stem-34 stem-234 stem-1234 stem-3 stem-23 stem-2 stem-12
    ]>

    large-type-pieces-chars = { [ (camel-case name), (string-from-code-point unicode index + offset) ] for name, index in large-type-pieces-names }

    separated-sextant-prefixes = <[
      1
      2 12
      3 13 23 123
      4 14 24 124 34 134 234 1234
      5 15 25 125 35 135 235 1235 45 145 245 1245 345 1345 2345 12345
      6 16 26 126 36 136 236 1236 46 146 246 1246 346 1346 2346 12346 56 156 256 1256 356 1356 2356 12356 456 1456 2456 12456 3456 13456 23456 123456
    ]>

    offset += large-type-pieces-names.length

    separated-sextant-chars = { [ (camel-case "separated-sextant-#prefix"), (string-from-code-point unicode index + offset) ] for prefix in separated-sextant-prefixes }

    block-element-names = <[
      upper-left-one-sixteenth        upper-centre-left-one-sixteenth        upper-centre-right-one-sixteenth        upper-right-one-sixteenth
      upper-middle-left-one-sixteenth upper-middle-centre-left-one-sixteenth upper-middle-centre-right-one-sixteenth upper-middle-right-one-sixteenth
      lower-middle-left-one-sixteenth lower-middle-centre-left-one-sixteenth lower-miffle-centre-right-one-sixteenth lower-middle-right-one-sixteenth
      lower-left-one-sixteenth        lower-centre-right-one-sixteenth       lower-centre-right-one-sixteenth        lower-right-one-sixteenth

      right-half-lower-one-quarter right-three-quarter-lower-one-quarter left-three-quarters-lower-one-quarter left-half-lower-one-quarter
      lower-half-left-one-quarter  lower-three-quarters-left-one-quarter upper-three-quarters-left-one-quarter upper-half-left-one-quarter
      left-half-upper-one-quarter left-three-quarters-upper-one-quarter right-three-quarters-upper-one-quarter right-half-upper-one-quarter

      upper-half-right-one-quarter upper-three-quarters-right-one-quarter lower-three-quarters-right-one-quarter lower-half-right-one-quarter
    ]>

    offset += separated-sextant-prefixes.length

    block-element-chars = { [ (camel-case name), (string-from-code-point unicode index + offset) ] for name, index in block-element-names }

    {
      large-type-pieces-chars,
      separated-sextant-chars,
      block-element-chars
    }