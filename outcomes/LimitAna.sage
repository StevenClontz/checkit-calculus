def generator():
    x=var("x")

    # Rational Function Factored
    ############################
    ### Generate 3 zeros to use in polynomials
    zeros = sample([i for i in range(-6, 7) if i != 0], 3)
    ## Construct numerator and denominator with a shared zero
    top1 = expand((x-zeros[0]) * (x-zeros[1]))
    bottom1 = expand((x-zeros[1]) * (x-zeros[2]))
    ## Evaluate the limit at the shared zero
    a1 = zeros[1]

    # Plug in the Number
    ####################
    ## 2 zeros on top, 2 zeros on bottom, 5th is where we evaluate the limit
    zeros = sample([i for i in range(-6, 7) if i != 0], 5)    
    ## Construct numerator and denominator, no shared zeros
    top2 = expand((x-zeros[0]) * (x-zeros[1]))
    bottom2 = expand((x-zeros[2]) * (x-zeros[3]))
    ## Evaluate somewhere else
    a2 = zeros[4]

    # Rationalize
    #############
    ## Choose some values to use that will make this not terrible
    value = choice(range(1,10))
    square = choice(range(1,7))^2
    ## Create numerator and denominator
    exp1 = sqrt(x+square-value) - sqrt(square)
    exp2 = x - value
    ## Shuffle them
    fraction = [exp1, exp2]
    shuffle(fraction)
    ## Construct top and bottom
    top3 = fraction[0]
    bottom3 = fraction[1]
    ## Evaluate at the zero
    a3 = value

    # Common Denominator
    ####################
    values = sample([i for i in range(-6, 7) if i != 0], 2)
    frac = 1/values[0]
    top4 = 1/(x - values[1] + values[0]) - frac
    bottom4 = x - values[1]
    a4 = values[1]

    limf1 = limit(top1/bottom1, x=a1)
    limf2 = limit(top2/bottom2, x=a2)
    limf3 = limit(top3/bottom3, x=a3)
    limf4 = limit(top4/bottom4, x=a4)

    # Choose Between Rationalize and Common Denominator
    ###################################################
    Name = choice([0,1])
    if Name==0:
        topChoice = top3
        bottomChoice = bottom3
        aChoice = a3
        limChoice = limf3
    else:
        topChoice = top4
        bottomChoice = bottom4
        aChoice = a4
        limChoice = limf4

    limits = [
        {"num":top1,"den":bottom1,"a":a1,"limit":limf1},
        {"num":top2,"den":bottom2,"a":a2,"limit":limf2},
        {"num":topChoice,"den":bottomChoice,"a":aChoice,"limit":limChoice},
    ]
    shuffle(limits)
    
    return {
      "limits": limits,
    }