def generator():
# Notes: This could definitely be improved! I (Reeve) coded this initially as 1 piecewise function for both parts, so some of the code if extremely convoluted in order to make that work. Things could definitely be improved to make numbers "nicer" for students.
    x = var('x')
    b = var('b')
    f="f"
    g="g"
    h="h"

    # Function Names
    functionnames=[f,g,h]
    shuffle(functionnames)

    # Parameterize Me!
    # Choose domain split for param piecewise function
    param_domainsplitlist = list(range(-3,0)) + list(range(1,6))
    param_x = choice(param_domainsplitlist)
    param_y = randint(-3,6)

    # Param Piece 1
    param_f1choice = choice(["linear","quadratic","rational"])
    # Force a choice by uncommenting the line below and defining f1choice
    #f1choice="rational"
    if param_f1choice == "linear":
        param_f1(x) = choice([b*x+choice([-1,1])*QQ(randint(1,12)/randint(1,5)),choice([-1,1])*QQ(randint(1,12)/randint(1,5))*x+b])
        parameter = solve(param_f1(x=param_x)-param_y,b)[0].rhs() # solve for b
    elif param_f1choice == "quadratic":
        quadcoeffs = [b,choice([-1,1])*randint(1,5),choice([-1,1])*QQ(randint(1,12)/randint(1,3))]
        shuffle(quadcoeffs)
        param_f1(x) = quadcoeffs[0]*x^2 + quadcoeffs[1]*x + quadcoeffs[2]
        parameter = solve(param_f1(x=param_x)-param_y,b)[0].rhs() # solve for b
    elif param_f1choice == "rational":
        # Determine 1 or 2 roots not equal to param_x for the denominator
        param_f1denrootlist = [n for n in range(param_x-5,param_x+6) if n!=param_x]
        param_f1denroot1 = choice(param_f1denrootlist)
        param_f1denroot2 = choice(param_f1denrootlist)
        param_f1den = x - param_f1denroot1
        dendegree = 1
        for i in range(0,randint(0,1)):
            param_f1den *= x - param_f1denroot2
            dendegree += 1
        # Determine 1 or 2 nonzero roots close to but not equal to param_x for the numerator (this might reduce to a linear function which you can avoid if you like...)
        # Note: param_x can't be zero or a root of the numerator if you want to be able to reliably solve for b
        param_f1numrootlist = [n for n in range(param_x-5,param_x+6) if n!=0 and n!=param_x]
        # If you want a rational function for sure, uncomment the the 2 lines below
        #param_f1numrootlist = [n for n in range(param_x-5,param_x+5) if n!=0 and n!=param_x and n!=param_f1denroot1 and n!=param_f1denroot2]
        #shuffle(param_f1numrootlist)
        param_f1numroot1 = choice(param_f1numrootlist)
        param_f1numroot2 = choice(param_f1numrootlist)
        param_f1num = choice([b*x - param_f1numroot1,x - param_f1numroot1*b])
        if dendegree < 2:
            param_f1num *= x - param_f1numroot2
        param_f1(x) = param_f1num.expand()/param_f1den.expand()
        parameter = solve(param_f1(x=param_x)-param_y,b)[0].rhs() # solve for b

    # Param piece 2 will connect to (param_x,param_y)
    # choose f2 based on complexity of f1
    if param_f1choice == "linear":
        param_f2choice = "quadratic"
    elif param_f1choice == "rational":
        param_f2choice = "linear"
    else:
        param_f2choice = choice(["linear","quadratic"])
    # Force a choice by uncommenting the line below and defining f2choice
    #param_f2choice = "quadratic"
    param_slope = choice([-1,1])*QQ(randint(1,5)/randint(1,2))
    param_line = param_slope*(x-param_x) + param_y
    if param_f2choice == "linear":
        param_f2 = param_line.full_simplify()
    elif param_f2choice == "quadratic":
        param_x2 = param_x + randint(-5,6)
        param_f2 = (choice([-1,1])*(x-param_x)*(x-param_x2) + param_line).full_simplify()

    # Choose inequalities for where param_f1 meets param_f2.
    param_f1ineq = choice(["<","\\leq"])
    if param_f1ineq == "<":
        param_f2ineq = "\\geq"
    else:
        param_f2ineq = ">"


    # Classify Discontinuity
    # Choose domain split for discontinuity piecewise function
    discont_domainsplitlist = list(range(-3,0)) + list(range(1,6))
    discont_x = choice(discont_domainsplitlist)
    # Choose a y value to aim for. This may be redefined for removable discontinuity to make numbers nicer.
    discont_y = choice([n for n in range(-3,7) if n!=0])

    # Determine discontinuity type
    discontinuitytype = choice(["removable discontinuity","jump discontinuity","infinite discontinuity"])
    # Force a discontinuity type by uncommenting the line below and adjusting the bit in quotes
    #discontinuitytype = "removable discontinuity"

    if discontinuitytype == "jump discontinuity":
        # Add more function types here if you like.
        discont_f2choice = choice(["rational"])
        if discont_f2choice == "rational":
            discont_f2numrootlist = [n for n in range(discont_x-3,discont_x+4) if n!= discont_x]
            discont_f2numroot1 = choice(discont_f2numrootlist)
            discont_f2numroot2 = choice(discont_f2numrootlist)
            discont_f2num = x-discont_f2numroot1
            numdegree = 1
            for i in range(0,randint(0,1)):
                discont_f2num *= x-discont_f2numroot2
                numdegree += 1
            # Choose possible denominator roots (not beyond discont_x and not including all roots of numerator).
            discont_f2denrootlist = [n for n in range(-5,discont_x) if n!=discont_f2numroot1]
            discont_f2den = x-choice(discont_f2denrootlist)
            if numdegree < 2:
                discont_f2den *= x-choice(discont_f2denrootlist)
            # Define discont_f2 so that discont_f2(discont_x) is not discont_y (ensure jump discontinuity)
            discont_f2 = discont_f2num.expand()/discont_f2den.expand()
            while discont_f2.full_simplify()(x=discont_x) == discont_y:
                discont_y = choice([n for n in range(-3,7) if n!=0])
            # Since it's a jump discontinuity, we'll make it so it's at least left- or right- continuous
            rightleftcontinuous = choice(["left-continuous","right-continuous"])
            if rightleftcontinuous == "left-continuous":
                discont_f1ineq = "\\leq"
                discont_f2ineq = ">"
            else:
                discont_f1ineq = "<"
                discont_f2ineq = "\\geq"

    if discontinuitytype == "infinite discontinuity":
        # Add more function types here if you like.
        discont_f2choice = choice(["rational"])
        if discont_f2choice == "rational":
            # The denominator should have discont_x as a root (or double root). We'll make sure that this discontinuity is not removable.
            discont_f2denroot1 = discont_x
            # Choose a second root of the denominator, most of the time less than discont_x
            discont_f2denroot2 = discont_x + randint(-5,1)
            # Choose roots of numerator
            # If discont_x is a double root of the denominator, allow it as a single root of the numerator, otherwise, don't!
            if discont_f2denroot2 == discont_x:
                discont_f2numroot1 = discont_x + randint(-5,5)
            else:
                discont_f2numroot1 = discont_x + randint(1,5)*choice([-1,1])
            discont_f2numroot2 = discont_x + randint(1,5)*choice([-1,1])
            # Define numerator and denominator
            discont_f2num = (x-discont_f2numroot1)*(x-discont_f2numroot2)
            discont_f2den = (x-discont_f2denroot1)*(x-discont_f2denroot2)
            discont_f2 = discont_f2num.expand()/discont_f2den.expand()
        rightleftcontinuous = choice(["left-continuous","neither left- nor right-continuous"])
        if rightleftcontinuous == "left-continuous":
            discont_f1ineq = "\\leq"
            discont_f2ineq = ">"
        else:
            discont_f1ineq = "<"
            discont_f2ineq = "\\geq"
            # Uncomment below to possibly exclude value in domain where functions meet
            #discont_f2ineq = choice([">","\\geq"])

    if discontinuitytype == "removable discontinuity":
        # Add more function types here if you like.
        discont_f2choice = choice(["rational"])
        if discont_f2choice == "rational":
            # Make sure discont_x is a root of the numerator and choose another
            discont_f2numroot2 = choice(list(range(discont_x-3,discont_x+4)))
            discont_f2num = (x-discont_x)*(x-discont_f2numroot2)
            # Make sure discont_x is a root of the denominator and choose another, not including either root of the numerator
            discont_f2denrootlist = [n for n in range(discont_x-4,discont_x+5) if n!=discont_x and n!=discont_f2numroot2]
            discont_f2denroot2 = choice(discont_f2denrootlist)
            discont_f2den = (x-discont_x)*(x-discont_f2denroot2)
            # Define discont_f2
            discont_f2 = expand(discont_f2num)/expand(discont_f2den)
            discont_f2simplified = (discont_f2num/discont_f2den).full_simplify()
            # Defining discont_y in this way here will make sure that discont_f1 meets up with discont_f2
            discont_y = discont_f2simplified(x=discont_x)
            # Choose if left- or right-continuous (or neither)
            rightleftcontinuous = choice(["left-continuous","neither left- nor right-continuous"])
            if rightleftcontinuous == "left-continuous":
                discont_f1ineq = "\\leq"
                discont_f2ineq = ">"
            else:
                discont_f1ineq = "<"
                discont_f2ineq = "\\geq"

    # Discontinuity Piece 1 will connect to (discont_x,discont_y)
    discont_f1choice = choice(["linear"])
    # Uncomment the line below to include the possibility of a quadratic function
    #discont_f1choice = choice(["linear","quadratic"])
    discont_slope = choice([-1,1])*QQ(randint(1,5)/randint(1,2))
    discont_line = discont_slope*(x-discont_x) + discont_y
    if discont_f1choice == "linear":
        discont_f1 = discont_line.full_simplify()
    elif discont_f1choice == "quadratic":
        discont_x2 = discont_x + randint(-5,6)
        discont_f1 = (choice([-1,1])*(x-discont_x)*(x-discont_x2) + discont_line).full_simplify()

    parametervars = [
        {
            "fn":functionnames[0],
            "x":param_x,
            # Note: because f1 contains 2 variables (x and b), we need to explicitly state f1 is a function of x, otherwise this will be displayed in a strange way
            "f1":param_f1(x),
            "f2":param_f2,
            "f1ineq":param_f1ineq,
            "f2ineq":param_f2ineq,
            "parameter":parameter,
        }
    ]

    discontinuityvars = [
        {
            "fn":functionnames[1],
            "x":discont_x,
            "f1":discont_f1,
            "f2":discont_f2,
            "f1ineq":discont_f1ineq,
            "f2ineq":discont_f2ineq,
            "discontinuitytype":discontinuitytype,
            "rightleftcontinuous":rightleftcontinuous,
        }
    ]

    return {
        "parameter": parametervars,
        "discontinuity": discontinuityvars,
    }