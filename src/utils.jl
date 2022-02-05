# ------------------------- number/string conversion ------------------------- #

"""
    int2hex

Converts a single integer to hex string, but with a minimal hex
string length of 2 for hex color codes.
"""
int2hex(i::Int) = i > 15 ? string(i, base=16) : string("0", string(i, base=16))

"""
    hex2ing("ff")

Converts a string with a hex number to an integer
"""
hex2int(hex::AbstractString) = parse(Int, hex, base=16)


# -------------------------- color types conversion -------------------------- #

"""
    rgb2hex(r, g, b)

Converta a RGB color to a Hex color.
"""
rgb2hex(rgb::RGB) = Hex(string("#", int2hex.(rgb)...))

"""
    rgb2hex(r, g, b)

Converta a `rgb` tuple of integers ∈ [0, 255] to a hex color code.
"""
rgb2hex(r::Number, g::Number, b::Number) = rgb2hex(RGB(r, g, b))



"""
    hex(Hex)

Converts a Hex string to a RGB color.
"""
hex2rgb(hex::Hex) = RGB([hex2int(hex.code[i:i+1]) for i in (1, 3, 5)])

"""
    hex("#ffffff")

Converts a hex string color code to a RGB color.
"""
hex2rgb(hex::AbstractString) = hex2rgb(Hex(hex))
