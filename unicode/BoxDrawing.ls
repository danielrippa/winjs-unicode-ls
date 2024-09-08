
  do ->

    { new-instance } = dependency 'primitive.Instance'
    { object-from-array, object-keys } = dependency 'native.Object'
    { type-error, Num } = dependency 'primitive.Type'
    { box-drawing-chars } = dependency 'unicode.u2500'
    { string-from-code-point } = dependency 'native.String'

    #

    unicode = -> 0x2500 + it

    uchar = -> string-from-code-point unicode it

    #

    {
      corner-kind, stroke-kind, weight-kind,
      any-kind, horizontal, vertical,
      single-stroke-char, quadruple-stroke-char, rounded-corner-char,
      horizontal-bar-char, vertical-bar-char, vertical-t-west-char, vertical-t-east-char,
      horizontal-t-north-char, horizontal-t-south-char,
      nw-corner-char, ne-corner-char, sw-corner-char, se-corner-char
    } = dependency 'unicode.BoxDrawingImpl'

    #

    bd = box-drawing-chars

    #

    { none, double, single } = stroke-kind

    #

    corner-kind-names = object-keys corner-kind
    stroke-kind-names = object-keys stroke-kind
    weight-kind-names = object-keys weight-kind

    #

    CornerKind = (value) ->

      type-error "Invalid CornerKind value '#value'. Valid values are: #{ corner-kind-names.join ', ' }" \
        unless value in corner-kind-names

      value

    StrokeKind = (value) ->

      type-error "Invalid StrokeKind value '#value'. Valid values are: #{ stroke-kind-names.join ', ' }" \
        unless value in stroke-kind-names

      value

    WeightKind = (value) ->

      type-error "Invalid WeightKind value '#value'. Valid values are: #{ weight-kind-names.join ', ' }" \
        unless value in weight-kind-names

      value

    #

    new-stroke = (stroke = stroke-kind.none, weight = weight-kind.light) ->

      new-instance do

        stroke:
          getter: -> stroke
          setter: -> stroke := StrokeKind it

        weight:
          getter: -> weight
          setter: -> weight := WeightKind it

    #

    sharp-corner-char = (char) ->

      { north, east, south, west } = char

      switch

        | any-kind south =>

          switch

            | any-kind east => se-corner-char char
            | any-kind west => sw-corner-char char

        | any-kind north =>

          switch

            | any-kind east => ne-corner-char char
            | any-kind west => nw-corner-char char

    #

    double-stroke-char = (char) ->

      match char

        | horizontal => horizontal-bar-char char
        | vertical   => vertical-bar-char   char

        else

          switch char.corner
            | corner-kind.rounded => rounded-corner-char char
            | corner-kind.sharp   => sharp-corner-char   char

    #

    horizontal-t-char = (char) ->

      { north, south } = char

      switch

        | any-kind north => horizontal-t-north-char char
        | any-kind south => horizontal-t-south-char char

    #

    vertical-t-char = (char) ->

      { east, west } = char

      switch

        | any-kind east => vertical-t-east-char char
        | any-kind west => vertical-t-west-char char

    #

    triple-stroke-char = (char) ->

      switch

        | horizontal char => horizontal-t-char char
        | vertical   char => vertical-t-char   char

    #

    box-drawing-char-as-string = (char) ->

      stroke-count = 0

      for stroke-name in <[ north east south west ]>
        stroke = char[ stroke-name ]
        if any-kind stroke
          stroke-count++

      switch stroke-count

        | 0 => bd.empty-block

        | 1 =>       single-stroke-char char
        | 2 => uchar double-stroke-char char
        | 3 => uchar triple-stroke-char char
        | 4 => uchar quadruple-stroke-char char

    new-box-drawing-char = ->

      corner = corner-kind.sharp

      north = new-stroke!
      east =  new-stroke!
      south = new-stroke!
      west =  new-stroke!

      new-instance do

        corner:
          getter: -> corner
          setter: -> CornerKind it ; corner := it

        north: getter: -> north
        east:  getter: -> east
        south: getter: -> south
        west:  getter: -> west

        to-string: member: -> box-drawing-char-as-string @

    #

    box-char = box-drawing-char = (north = none, east = none, south = none, west = none) ->

      char = new-box-drawing-char!

        ..north.stroke = north
        ..east.stroke  = east
        ..south.stroke = south
        ..west.stroke  = west

      char

    #

    single-chars =

      nw: box-char single, none, single
      ne: box-char none, none, single, single
      sw: box-char single, none, single
      se: box-char single, none, none, single

      vertical: box-char single, none, single
      horizontal: box-char none, single, none, single

      vertical-and-horizontal: single, single, single, single

    #

    double-chars =

      nw: box-char double, none, double
      ne: box-char none, none, double, double
      sw: box-char double, none, double
      se: box-char double, none, none, double

      vertical: box-char double, none, double
      horizontal: box-char none, double, none, double

      vertical-and-horizontal: double, double, double, double

    {
      box-drawing-chars,
      corner-kind, stroke-kind, weight-kind,
      CornerKind, StrokeKind, WeightKind,
      new-stroke,
      new-box-drawing-char, box-drawing-char,
      single-chars, double-chars
    }
