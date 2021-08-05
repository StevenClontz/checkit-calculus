def generator():
    x,y = var("x y")

    specials = [sin,cos,exp]
    shuffle(specials)
    terms = [
        randrange(1,6)*choice([-1,1])*x^randrange(2,6),
        randrange(1,6)*choice([-1,1])*y^randrange(2,6),
        randrange(1,6)*choice([-1,1])*specials[0](x)*y,
        randrange(1,6)*choice([-1,1])*specials[1](y)*x,
    ]
    shuffle(terms)
    equations = []

    for n in range(2):
        equation = shuffled_equation(
            randrange(1,6)*choice([-1,1]),
            *terms[2*n:2*n+2]
        )

        yp_top = -sum([terms[i].diff(x) for i in range(2*n,2*n+2)])
        yp_bot = sum([terms[i].diff(y) for i in range(2*n,2*n+2)])

        equations.append({
            "equation": equation,
            "yp": yp_top/yp_bot,
        })

    return {"equations":equations}
