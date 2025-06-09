return {
  black = 0xff181819,
  white = 0xfff5e0dc,
  red = 0xfffc5d7c,
  green = 0xff9ed072,
  blue = 0xff89b4fa,
  yellow = 0xffe7c664,
  orange = 0xfff39660,
  magenta = 0xffb4befe,
  grey = 0xff7f8490,
  transparent = 0x00000000,
  maroon = 0xffeba0ac,
  mauve = 0xffcba6f7,
  lavender = 0xffb4befe,
  teal = 0xff94e2d5,
  peach = 0xfffab387,


  bar = {
    bg = 0x901e1e2e,
    border = 0xffa6adc8,
  },
  popup = {
    bg = 0xc02c2e34,
    border = 0xffb4befe,
  },
  bg1 = 0x881b1b1b,
  bg2 = 0x55cba6f7,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
