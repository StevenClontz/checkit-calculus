def generator():
    x=var("x")
    y=var("y")
    t=var("t")
    w=var("w")
    f="f"
    g="g"
    h="h"

    listvars=[x,y,t,w]
    shuffle(listvars)

    functionnames=[f,g,h]
    shuffle(functionnames)

    polynomial=sum([randrange(1,6)*choice([-1,1])*x^i for i in range(3)])

    specials = [
        exp,
        log,
        sin,
        cos
    ]
    shuffle(specials)

    f1 = choice([-1,1])*randrange(1,10)*specials[0](polynomial(x=listvars[0]))

    primes = [2,3,5,7]
    shuffle(primes)
    f2 = choice([-1,1])*randrange(1,10)*specials[1](listvars[1])^(primes[0]/primes[1])

    df1=f1.diff()
    df2=f2.diff()

    functions = [
        {"f":f1,"dfdx":df1, "fn": functionnames[0], "v": listvars[0]},
        {"f":f2,"dfdx":df2, "fn": functionnames[1], "v": listvars[1]},
    ]
    shuffle(functions)


    return {
      "functions": functions,
    }

