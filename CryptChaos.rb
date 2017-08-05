samps = "~/desktop/crypt/" ##| link to a sample lib

startP1 = (scale :c,:augmented).tick ##| start point are a division of the first three notes on the augmented scale with root middle c. This info becomes part of the encryption key and can change accordingly.
startP2 = (scale :c,:augmented).look
startP3 = (scale :c,:augmented).look

x0 = startP1*0.1##| start points
y0 = startP2*0.1
z0 = startP3*0.1

t=0.01 ##| time step to each itteration..

rho = 28.0
sigma = 10.0
betaA = 8.0
betaB = 3.0

##| // Lorenz
live_loop :lorenz do
  use_bpm 160 ##| because 160..
  x = x0 + (t*sigma*(y0-x0))
  y = y0 + (t*((x0*(rho-z0))-y0))
  z = z0 + (t*((x0*y0)-(betaA*z0/betaB)))
  x0=x
  y0=y
  z0=z
  puts(x,y,z)
  puts(t)
  sleep 1
  puts (x0*y0*z0)
end

live_loop :encrypt do
  use_random_seed x0*y0*z0 + 12345 ##| example of how the determinisim of intials combined with a static rseed will create an encryption key..
  a = (ring 40,30,20,10).shuffle.look
  i = 0
  k = 0
  num = 258
  l = (ring 3, 13, 9, 4).look
  e = (ring 4, 24, 16, 11).look
  m = (ring 11, 5, 7, 4).look
  o = (ring 24, 12, 12, 7).look
  r = (ring 1,2,3,4,5,6).shuffle.look
  
  while i <= num  do
      k +=0.01
      a -=0.01
      puts(a)
      puts(l,e)
      puts(m,o)
      puts(i)
      puts(k)
      puts(num)
      sample samps, i.to_s,rate: 0.05*(r*x0),amp: k+4, pan: rrand(-1,1) if spread(l,e).tick ##| Euclidian rythm necklaces become part of the encryption key..
      sample samps, i.to_s,rate: 0.05*(r*y0), amp: k+4, pan: rrand(-1,1) if spread(m,o).look
      i +=1
      sleep 0.25/a
      if ( i >= 900)
        a = rrand(1,2)
        k = 5.5 + rrand(0,1)
      end
    end
    
    i = 258
    num = 0
    k = 10
    a = (ring 40,30,20,10).shuffle.look
    l = (ring 3, 13, 9, 4).look
    e = (ring 4, 24, 16, 11).look
    m = (ring 11, 5, 7, 4).look
    o = (ring 24, 12, 12, 7).look
    r = (ring 1,2,3,4,5,6).shuffle.look
    
    use_random_seed x0*y0*z0 + 10000
    
    while i >= num  do
        k -=0.01
        a -=0.01
        puts(a)
        puts(l,e)
        puts(m,o)
        puts(i)
        puts(k)
        sample samps, i.to_s, rate: 0.05*(r*x0),amp: k+4, pan: rrand(-1,1) if spread(m,o).tick
        sample samps, i.to_s, rate: 0.05*(r*y0),amp: k+4, pan: rrand(-1,1) if spread(l,e).look
        i -=1
        sleep 0.25/a
        if ( i <= 100)
          a = rrand(1,2)
          k = 5.5 + rrand(0,1)
        end
      end
      
    end
    