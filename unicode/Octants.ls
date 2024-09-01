
  do ->

    { box-drawing-chars: bd } = dependency 'unicode.u2500'
    { block-element-chars: b1 } = dependency 'unicode.u1ce00'
    { block-element-chars: b2, sextant-chars: s } = dependency 'unicode.u1fb00'
    { octant-chars } = dependency 'unicode.u1cd00'
    { square-root, floor, ceiling } = dependency 'native.Number'
    { Num, Bool } = dependency 'primitive.Type'
    { boolean-as-binary-digit, binary-digit-as-boolean } = dependency 'native.Boolean'
    { map-items } = dependency 'native.Array'

    #
  
    missing-chars =

      '': bd.empty-block

      1: b1.left-half-upper-one-quarter
      2: b1.right-half-upper-one-quarter
      7: b1.left-half-lower-one-quarter
      8: b1.right-half-lower-one-quarter
      12: b2.upper-one-quarter
      13: s.sextant13
      24: bd.quadrant-upper-right
      35: b2.middle-left-one-quarter
      46: b2.middle-right-one-quarter
      57: bd.quadrant-lower-left
      68: bd.quadrant-lower-right
      78: bd.lower-one-quarter
      1234: bd.upper-half
      1357: bd.left-half
      1368: bd.quadrant-upper-left-and-lower-right
      1537: bd.left-half
      2457: bd.quadrant-upper-right-and-lower-left
      2468: bd.right-half
      5678: bd.lower-half
      123456: b2.upper-three-quarters
      123457: bd.quadrant-upper-left-and-upper-right-and-lower-left
      123468: bd.quadrant-upper-left-and-upper-right-and-lower-right
      135678: bd.quadrant-upper-left-and-lower-left-and-lower-right
      245678: bd.quadrant-upper-right-and-lower-left-and-lower-right
      345678: bd.lower-three-quarters
      12345678: bd.full-block

    missing-chars = { [ "octant-#key", char ] for key, char of missing-chars }

    octant-chars <<< missing-chars

    #

    new-octant-char = ->

      var bits

      clear = !-> bits := [ off for til 8 ]

      clear!

      width = floor square-root bits.length

      #

      index = (x, y) -> Num x ; Num y ; i = y + (x * width);

      key-suffix = -> [ "#{ i + 1 }" for bit, i in bits when bit ] * ''

      #

      get: (x, y) -> i = index x, y ; bits[ i ]
      set: (x, y, bit = on) !-> bits[ (index x, y) ] := Bool bit

      to-string: -> key = "octant-#{ key-suffix! }" ; outln key ; octant-chars[ key ]

    #

    coords-from-index = (index) -> x = index |> (/ 2) |> ceiling |> (- 1) ; y = index |> (- 1) |> (% 2) ; [ x, y ]

    char-bit-from-coords = (char, [ x, y ]) -> char.get x, y

    char-bit-from-index = (char, index) -> coords-from-index index |> char-bit-from-coords char, _

    octant-char-as-binary = (char) -> [ (boolean-as-binary char-bit-from-index index) for index til 8 ] * ''

    #

    octant-char-from-boolean-array = (array) ->

      char = new-octant-char!

      for bit, index in array.reverse! => [ x, y ] = coords-from-index index + 1 ; if bit then char.set x, y

      char

    octant-char-from-binary = (binary) -> binary / '' |> map-items _ , binary-digit-as-boolean |> octant-char-from-boolean-array

    {
      new-octant-char,
      octant-char-as-binary, octant-char-from-binary,
      octant-char-from-boolean-array
    }
