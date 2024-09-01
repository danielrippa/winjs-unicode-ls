
  do ->

    { Num } = dependency 'primitive.Type'
    { string-from-code-point, camel-case } = dependency 'native.String'

    unicode = -> 0x1fb00 + Num it

    char = -> string-from-code-point unicode it

    #

    sextant-suffixes = <[
      1
      2 12
      3 13 23 123
      4 14 24 124 34 134 234 1234
      5 15 25 125 35 235 1235 45 145 245 1245 345 1345 2345 12345
      6 16 26 126 36 136 236 1236 46 146 1246 346 1346 2346 12346 56 156 256 1256 356 1356 2356 12356 456 1456 2456 12456 3456 13456 23456
    ]>

    sextant-names = [ ("sextant-#suffix") for suffix in sextant-suffixes ]

    sextant-chars = { [ (camel-case name), (char index) ] for name, index in sextant-names }

    #

    smooth-mosaic-names = <[
      lower-left-lower-middle-left-to-lower-centre
      lower-left-lower-middle-left-to-lower-right
      lower-left-upper-middle-left-to-lower-centre
      lower-left-upper-middle-left-to-lower-right

      lower-left-upper-left-to-lower-centre

      lower-right-upper-middle-left-to-upper-centre
      lower-right-upper-middle-left-to-upper-right
      lower-right-lower-middle-left-to-upper-centre
      lower-right-lower-middle-left-to-upper-right

      lower-right-lower-left-to-upper-centre

      lower-right-lower-middle-left-to-upper-middle-right
      lower-right-lower-centre-to-lower-middle-right
      lower-right-lower-left-to-lower-middle-right
      lower-right-lower-centre-to-upper-middle-right
      lower-right-lower-left-to-upper-middle-right
      lower-right-lower-centre-to-upper-right

      lower-left-upper-centre-to-upper-middle-right
      lower-left-upper-left-to-upper-middle-right
      lower-left-upper-centre-to-lower-middle-right
      lower-left-upper-left-to-lower-middle-right
      lower-left-upper-centre-to-lower-right
      lower-left-upper-middle-left-to-lower-middle-right

      upper-right-lower-middle-left-to-lower-centre
      upper-right-lower-middle-left-to-lower-right
      upper-right-upper-middle-left-to-lower-centre
      upper-right-upper-middle-left-to-lower-right

      upper-right-upper-left-to-lower-centre
      upper-left-upper-middle-left-to-upper-centre

      upper-left-upper-middle-left-to-upper-right
      upper-left-lower-middle-left-to-upper-centre
      upper-left-lower-middle-left-to-upper-right

      upper-left-lower-left-to-upper-centre

      upper-left-lower-middle-left-to-upper-middle-right
      upper-left-lower-centre-to-lower-middle-right
      upper-left-lower-left-to-lower-middle-right
      upper-left-lower-centre-to-upper-middle-right
      upper-left-lower-left-to-upper-middle-right
      upper-left-lower-centre-to-upper-right

      upper-right-upper-centre-to-upper-middle-right
      upper-right-upper-left-to-upper-middle-right
      upper-right-upper-centre-to-lower-middle-right
      upper-right-upper-left-to-lower-middle-right
      upper-right-upper-centre-to-lower-right
      upper-right-upper-middle-left-to-lower-middle-right

      upper-and-right-and-lower-triangular-three-quarters-block
      left-and-lower-and-right-triangular-three-quarters-block
      upper-and-left-and-lower-triangular-three-quarters-block
      left-and-upper-and-right-triangular-three-quarters-block
    ]>

    offset = sextant-names.length

    smooth-mosaic-chars = { [ (camel-case name), (char index + offset) ] for name, index in smooth-mosaic-names }

    #

    triangular-names = <[
      left upper rigth lower
    ]>

    offset += smooth-mosaic-names.length

    triangular-chars = { [ (camel-case "triangular-#name"), (char index + offset) ] for name, index in triangular-names }

    #

    suffixes = <[ 2 3 4 5 6 7 ]>

    vertical-block-names = [ "vertical-one-eight#suffix" for suffix in suffixes ]

    offset += triangular-names.length

    vertical-block-chars = { [ (camel-case name), (char index + offset) ] for name, index in vertical-block-names }

    #

    horizontal-block-names = [ "horizontal-one-eight#suffix" for suffix in suffixes ]

    offset += vertical-block-names.length

    horizontal-block-chars = { [ (camel-case name), (char index + offset) ] for name, index in horizontal-block-names }

    #

    block-element-names = <[
      left-and-lower-one-eighth
      left-and-upper-one-eighth
      right-and-upper-one-eighth
      right-and-lower-one-eighth
      upper-and-lower-one-eighth
    ]>

    offset += horizontal-block-names.length

    block-element-chars = { [ (camel-case name), (char index + offset) ] for name, index in block-element-names }

    #

    block-names = <[
      one-quarter
      three-eighths
      five-eighths
      three-quarters
      seven-eighths
    ]>

    offset += 1 + block-element-names.length

    upper-block-chars = { [ (camel-case "upper-#name"), (char index + offset) ] for name, index in block-names }

    #

    offset += block-names.length

    right-block-chars = { [ (camel-case "right-#name"), (char index + offset) ] for name, index in block-names }

    #

    fill-names = <[
      checker-board
      inverse-checker-board

      heavy-horizontal
    ]>

    offset = 0x95

    fill-chars = { [ (camel-case "#{name}-fill"), (char index + offset) ] for name, index in fill-names }

    #

    triangular-half-names = <[
      upper-and-lower left-and-right
    ]>

    offset = 0x9a

    triangular-half-chars = { [ (camel-case "#{ name }-triangular-half"), (char index + offset) ] for name, index in triangular-half-names }

    #

    offset = 0xce

    left-block-names = <[ two-thirds one-third ]>

    left-block-chars = { [ (camel-case "left-#name"), (char index + offset) ] for name, index in left-block-names }

    #

    offset = 0xe4

    geometric-names = <[
      upper-centre-one-quarter
      lower-centre-one-quarter
      middle-left-one-quarter
      middle-right-one-quarter
    ]>

    geometric-chars = { [ (camel-case name), (char index + offset) ] for name, index in geometric-names }

    #

    circle-names = <[
      top-justified-lower-half
      right-justified-left-half
      bottom-justified-upper-half
      left-justified-right-half
      top-right-justified-lower-left-quarter
      bottom-left-justified-upper-right-quarter
      bottom-right-justified-upper-right-quarter
      top-left-justified-lower-right-quarter
    ]>

    offset += geometric-names.length

    circle-chars = { [ ("#{ name }-circle"), (char index + offset) ] for name in circle-names }

    #

    offset += circle-names.length

    segmented-digit-chars = { [ ("segmented-digit-#index"), (char index + offset) ] for index til 9 }

    #

    block-element-chars <<< vertical-block-chars <<< horizontal-block-chars <<< upper-block-chars <<< right-block-chars <<< left-block-chars <<< geometric-chars

    triangular-chars <<< triangular-half-chars

    {
      sextant-chars,
      smooth-mosaic-chars,
      triangular-chars,
      block-element-chars,
      circle-chars,
      segmented-digit-chars
    }