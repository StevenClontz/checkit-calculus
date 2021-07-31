def generator():
    x=var("x")
    
    numterms=randint(2,4)
    powers=[0,1,2,3,4]
    shuffle(powers)
    
    chosenpowers=[powers[i] for i in range(numterms)]
    
    chosenpowers=chosenpowers.sort()

    funcname=choice(["f", "g", "h", r"\alpha"])


    poly(x)=0
    
    for i in range(numterms):
        poly(x)=poly(x)+randint(1,6 - i)*choice([1,-1])*x^(powers[i])
        
    polyexp=poly(x)
    
    a=randint(1,3)*choice([-1,1])
    fa=poly(a)

    dfdx(x)=poly(x).diff()

    slope=dfdx(x=a)

    tanline=slope*(x-a)+fa

    tanline=tanline.full_simplify()





    return {
        "poly": polyexp,
        "function_symbol": funcname,
        "pointx": a,
        "pointy": fa,
        "tanline": tanline,
    }