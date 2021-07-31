# Compute derivatives using a combination of rules.

def generator():
    x=var("x")
    y=var("y")
    t=var("t")
    w=var("w")
    f="f"
    g="g"
    h="h"

    index1 = randint(0, 3)
    index2 = randint(0, 3)
    index3 = randint(0, 3)

    listvars=[x,y,t,w]
    shuffle(listvars) #function name index

    functionnames=[f,g,h]
    shuffle(functionnames) #function name index
    
    x1 = listvars[0]
    x2 = listvars[1]
    x3 = listvars[2]
    
    ## send exponent to xml file separately.  remember to differentiate f1^exp_f1
    exp_f1 = randint(2,6)
    f1 = ((randint(1,6)*choice([-1,1])*x1^randint(1,6) + randint(1,6)*choice([-1,1]))/(randint(1,6)*choice([-1,1])*x1^randint(1,6) + randint(1,6)*choice([-1,1])))
    f1_ = f1^exp_f1
    
    trig = [
            cos(randint(1,6)*choice([-1,1])*x2^randint(2,4) + randint(1,6)*choice([-1,1])*x2^randint(0,1)),
            sin(randint(1,6)*choice([-1,1])*x2^randint(2,4) + randint(1,6)*choice([-1,1])*x2^randint(0,1)),
           ]
    shuffle(trig)
    f2 = sqrt(trig[0])
    
    f3 = randint(1,6)*x3^(1/randint(2,4)) * (randint(1,6)*x3^randint(1,6) + randint(1,6)*choice([-1,1])*x3^randint(0,6))^randint(1,6)
    
    df1_p1 = f1.diff()
    df1 = f1_.diff()
    df2 = f2.diff()
    df3 = f3.diff()

    
    return {
      "f1": f1,
      "exp_f1": exp_f1,
      "f2": f2,
      "f3": f3,
      "xp": listvars[0],
      "xe": listvars[1],
      "xt": listvars[2],
     "fn1": functionnames[0],
     "fn2": functionnames[1],
     "fn3": functionnames[2],
    "df1":df1,
        "exp_f1": exp_f1,
        "exp_f1_": exp_f1 -1,
        "df1_p1": df1_p1,
        "df2":df2,
        "df3":df3,
    }





