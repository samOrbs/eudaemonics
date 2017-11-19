# Lyapunov Exponent Calculation (L) re-Written in Ruby from Old C example taken from C.Pickovers Chaos In Wonderland.
a = rrand(-3,0) # a > -3
b = rrand(0,3) # b < 3
c = rrand(0,0.5) # 0.5 < c
d = rrand(0,1.5) # d < 1.5

Lsum = 0
n = 0
x = 0.1
y = 0.1
xe = x + 0.000001
ye = y

(10**7).times do
  xx = Math.sin(y*b) + c*Math.sin(x*b)
  yy = Math.sin(x*a) + d*Math.sin(y*a)
  xsave = xx
  ysave = yy
  x = xe
  y = ye
  n+=1
  
  # Re-Iterate for computing Lyapunov Exponent (L)
  xx = Math.sin(y*b) + c*Math.sin(x*b)
  yy = Math.sin(x*a) + d*Math.sin(y*a)
  dLx = xx - xsave
  dLy = yy - ysave
  dL2 = dLx*dLx + dLy*dLy
  df = 1000000000000.*dL2
  rs = 1./Math.sqrt(df)
  xe = xsave + rs*(xx - xsave)
  ye = ysave + rs*(yy - ysave)
  xx = xsave
  yy = ysave
  Lsum = Lsum + Math.log(df)
  L = 0.721347*Lsum/n
  x = xx
  y = yy
  # L is the value for the Lyapunov exponent
  sleep 0.125
  puts(L)
  puts(n)
end
