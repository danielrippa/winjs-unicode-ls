
  do ->

    { Num } = dependency 'primitive.Type'
    { string-from-code-point } = dependency 'native.String'

    unicode = -> 0x1cc00 + Num it

    quadrant-suffixes = <[
      1
      2 12
      3 13 23 123
      4 14 24 124 34 134 234 1234
    ]>

    separated-quadrant-chars = { [ ("separated-quadrant-#suffix"), (string-from-code-point unicode index + 0x21 ) ] for suffix in quadrant-sufixes }

    u1cc00-chars = separated-quadrant-chars

    {
      separated-quadrant-chars,
      u1cc00-chars
    }