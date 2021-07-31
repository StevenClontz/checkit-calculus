def generator():
    x=var("x")

    # RATIONAL FUNCTION
    ###################
    ## Choose where the larger degree polynomial is
    case1 = choice(["top", "bottom", "same"])
    # Construct polynomials
    biggest_power = randrange(3,7)
    smaller_powers = list(range(biggest_power))

    coeffs = list(IntegerRange(1,10))+list(IntegerRange(-9,0))
    shuffle(coeffs)

    if case1 == "same": 
        top = coeffs[0]*x^biggest_power + \
            coeffs[1]*x^choice(smaller_powers) + \
            coeffs[2]*x^choice(smaller_powers)
        bottom = coeffs[3]*x^biggest_power + \
            coeffs[4]*x^choice(smaller_powers) + \
            coeffs[5]*x^choice(smaller_powers)
    elif case1 == "top":
        top = coeffs[0]*x^biggest_power + \
            coeffs[1]*x^choice(smaller_powers) + \
            coeffs[2]*x^choice(smaller_powers)
        bottom = coeffs[3]*x^choice(smaller_powers) + \
            coeffs[4]*x^choice(smaller_powers) + \
            coeffs[5]*x^choice(smaller_powers)
    elif case1 == "bottom":
        bottom = coeffs[0]*x^biggest_power + \
            coeffs[1]*x^choice(smaller_powers) + \
            coeffs[2]*x^choice(smaller_powers)
        top = coeffs[3]*x^choice(smaller_powers) + \
            coeffs[4]*x^choice(smaller_powers) + \
            coeffs[5]*x^choice(smaller_powers)
    # Rational Function and limit
    f1 = top / bottom
    a1 = choice([infinity, -1 * infinity])
    limf1 = limit(f1, x=a1)
    
    # PSEUDO RATIONAL FUNCTION
    ##########################
    # Don't use the same case as above
    case2 = choice(["top", "bottom"])
    while case2 == case1:
        case2 = choice(["top", "bottom"])
    # Which expression has the larger exponent?
    bigger = choice(["root", "polynomial"])
    # Construct polynomial random degree polynomial with n terms
    biggest_power = randrange(3,5)
    smaller_powers = list(range(biggest_power))
    polynomial = 0
    nterms = randint(2,3)
    for i in range(nterms-1):
        exponent = choice(smaller_powers)
        newterm = choice(coeffs) * x^exponent
        polynomial += newterm
        smaller_powers.remove(exponent)
    polynomial += choice(coeffs) * x^biggest_power
    # Construct root
    sign_on_diff = 2 * ("root"==bigger) - 1
    diff = choice([1,3,5])
    root_exponent = 2 * biggest_power + sign_on_diff * diff
    ### Stuff under the root?
    nterms = randint(0,1)
    smaller_powers = list(range(root_exponent))
    under_root = x^root_exponent
    for i in range(nterms):
        exponent = choice(smaller_powers)
        newterm = choice(coeffs) * x^exponent
        under_root += newterm
        smaller_powers.remove(exponent)
    ### Stuff outside the root?
    nterms = randint(0,1)
    smaller_powers = list(range(floor(root_exponent/2)))
    outside_root = 0
    for i in range(nterms):
        exponent = choice(smaller_powers)
        newterm = choice(coeffs) * x^exponent
        outside_root += newterm
        smaller_powers.remove(exponent)
    root = choice(coeffs) * sqrt(under_root) + outside_root
    # Put together into function
    if bigger == "root" and case2 == "top":
        f2 = root / polynomial
    elif bigger == "root" and case2 == "bottom":
        f2 = polynomial / root
    elif bigger == "polynomial" and case2 == "top":
        f2 = polynomial / root
    elif bigger == "polynomial" and case2 == "bottom":
        f2 = root / polynomial
    # limit
    a2 = choice([infinity, -1 * infinity])
    limf2 = limit(f2, x=a2)


    limitsatinf = [
        {"f":f1,"a":a1,"limit":limf1},
        {"f":f2,"a":a2,"limit":limf2},
    ]
    shuffle(limitsatinf)

    return {
      "limitsatinf": limitsatinf,
    }