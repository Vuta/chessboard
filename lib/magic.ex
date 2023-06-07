defmodule Magic do
  # These magics are generated by Helper.generate_magics/2
  @bishop_magics Arrays.new([
    0xB102080A1000000,
    0x1821084100080004,
    0x105082808084800,
    0x12430210000041,
    0x811688080410000,
    0x408880000440040,
    0x1821084100080004,
    0x502400B02884,
    0x7140410000028,
    0xA0040882220006,
    0x120822000284,
    0x105082808084800,
    0x88034500201840,
    0x105082808084800,
    0x20A000680C000004,
    0x10220C8440840194,
    0x20040440080A4030,
    0x105421005000000,
    0x128C0206000302,
    0x880840020021,
    0x4010044015900,
    0x801050800450400,
    0x128C0206000302,
    0x128C0206000302,
    0x2004A60004800200,
    0x2004A60004800200,
    0x880840020021,
    0x880840020021,
    0x880840020021,
    0x1821084100080004,
    0x4010044015900,
    0x811688080410000,
    0x1821084100080004,
    0x8006210420010000,
    0x502400B02884,
    0xA01120801803088,
    0x88440C0800000000,
    0x880840020021,
    0x4010044015900,
    0x4010044015900,
    0x88034500201840,
    0x210A420E08800102,
    0x105082808084800,
    0x8010010A40000001,
    0x8010010A40000001,
    0x8120008C10104100,
    0x1821084100080004,
    0x1821084100080004,
    0x1821084100080004,
    0x460810090020,
    0x211480800040,
    0x4610080042002000,
    0xA142011080,
    0x460810090020,
    0x205101042080881,
    0x1821084100080004,
    0x502400B02884,
    0x10220C8440840194,
    0xA840180034460010,
    0x8488800001106049,
    0x49480048892008,
    0x125210100820,
    0x7140410000028,
    0xB102080A1000000
  ])

  @rook_magics Arrays.new([
    0x4610080042002000,
    0x263080000004004,
    0xA01120801803088,
    0x80804005100190,
    0x263080000004004,
    0x2408100004000102,
    0x2408100004000102,
    0x3010000101041080,
    0x408880000440040,
    0x3000610000810000,
    0x9000C00000000800,
    0x640012000020C,
    0x102010004408C0,
    0x880840020021,
    0x4010044015900,
    0x2408100004000102,
    0x2408100004000102,
    0x105082808084800,
    0x880840020021,
    0x105082808084800,
    0x105082808084800,
    0x4140080004002804,
    0x3000610000810000,
    0x3000610000810000,
    0x640012000020C,
    0x8120008C10104100,
    0x502400B02884,
    0x105082808084800,
    0x30280400022800,
    0xB102080A1000000,
    0x8001000408100280,
    0x102010004408C0,
    0xC040A20000400,
    0x105082808084800,
    0x8120008C10104100,
    0x105082808084800,
    0xF80204014000104,
    0x880840020021,
    0x8001000408100280,
    0x8001000408100280,
    0x609800410044080,
    0x12430210000041,
    0xC040A20000400,
    0xA01120801803088,
    0xA01120801803088,
    0xF80204014000104,
    0x460810090020,
    0x8001000408100280,
    0x848100221000006,
    0xA01120801803088,
    0x811688080410000,
    0x502400B02884,
    0x502400B02884,
    0x128C0206000302,
    0x2034501018840001,
    0x2034501018840001,
    0xF80204014000104,
    0x2120088050212,
    0x49480048892008,
    0x811688080410000,
    0x2120088050212,
    0x2034501018840001,
    0x8001000408100280,
    0x8001000408100280
  ])

  defstruct bishop: @bishop_magics, rook: @rook_magics
end
