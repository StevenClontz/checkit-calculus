def generator():
    x = var("x")
    xs = list(var("x y z t"))

    # standard reverse chain rule
    options = choice(
        [
            {
                "outs": [
                    randrange(1,10)*x^randrange(3,6),
                ],
                "ins": [
                    randrange(1,10)*cos(x)+randrange(1,10)*choice([-1,1]),
                    randrange(1,10)*sin(x)+randrange(1,10)*choice([-1,1]),
                    randrange(1,10)*exp(x)+randrange(1,10)*choice([-1,1]),
                    randrange(1,10)*log(x)+randrange(1,10)*choice([-1,1]),
                ]
            },
            {
                "outs": [
                    randrange(1,10)*exp(x),
                    randrange(1,10)*log(x),
                    randrange(1,10)*x^(-randrange(2,5)),
                ],
                "ins": [
                    randrange(1,10)*cos(x)+randrange(1,10)*choice([-1,1]),
                    randrange(1,10)*sin(x)+randrange(1,10)*choice([-1,1]),
                    x^randrange(3,6)+randrange(1,10)*choice([-1,1]),
                ]
            },
            {
                "outs": [
                    randrange(1,10)*sin(x),
                    randrange(1,10)*cos(x),
                ],
                "ins": [
                    randrange(1,10)*exp(x)+randrange(1,10)*choice([-1,1]),
                    randrange(1,10)*log(x)+randrange(1,10)*choice([-1,1]),
                    x^randrange(3,6)+randrange(1,10)*choice([-1,1]),
                ]
            },
        ]
    )
    shuffle(xs)
    result = choice(options["outs"])(x=choice(options["ins"]))(x=xs[0])
    integrand = result.diff()
    integrals = [
        {
            "variable": xs[0],
            "result": result,
            "integrand": integrand,
        }
    ]

    # fractional power with solving for x
    a = randrange(2,10)*choice([-1,1])
    b = randrange(1,5)*choice([-1,1])
    n = randrange(2,5)
    integrand = a*xs[1]*(xs[1]+b)^(1/n)
    result = integrate(integrand,xs[1])
    integrals.append(
        {
            "variable": xs[1],
            "result": result,
            "integrand": latex(a*xs[1])+latex((xs[1]+b)^(1/n)),
        }
    )

    shuffle(integrals)

    return { "integrals": integrals }
