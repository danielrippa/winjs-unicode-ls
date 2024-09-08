
  do ->

    { object-from-array } = dependency 'native.Object'

    ck = corner-kind = object-from-array <[ sharp rounded ]>
    sk = stroke-kind = object-from-array <[ none single double doubledash tripledash quadrupledash ]>
    wk = weight-kind = object-from-array <[ light bold ]>

    rounded = (.corner is ck.rounded)
    sharp   = (.corner is ck.sharp)

    none = (.stroke is sk.none)
    any-kind = -> not none it

    single = (.stroke is sk.single)
    double = (.stroke is sk.double)
    ddash  = (.stroke is sk.doubledash)
    tdash  = (.stroke is sk.tripledash)
    qdash  = (.stroke is sk.quadrupledash)

    single-or-double = ({ stroke }, single-value, double-value) ->

      switch stroke
        | sk.single => single-value
        | sk.double => double-value

    light = (.weight is wk.light)
    bold  = (.weight is wk.bold)

    light-or-bold = ({ weight }, light-value, bold-value) ->

      switch weight
        | wk.light => light-value
        | wk.bold  => bold-value

    are = (stroke-fn, stroke1, stroke2) -> stroke-fn stroke1 and stroke-fn stroke2

    horizontal = (char) -> are any-kind, char.west,  char.east
    vertical   = (char) -> are any-kind, char.north, char.south

    {
      corner-kind, stroke-kind, weight-kind,
      sharp, rounded, none, any-kind,
      single, double, single-or-double,
      ddash, tdash, qdash,
      light, bold, light-or-bold,
      are,
      horizontal, vertical
    }