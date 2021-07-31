def generator():
    x,y = var("x y")
    #generate the point at which the linear approximation is done
    a=randrange(1,10)*choice([-1,1])

    #generate the equation for the linear approximation mx+b
    m = randrange(1,10)*choice([-1,1])
    b = randrange(-9,10)
    linefunc(x) = m*x+b

    #generate a dx and find the approximation at a2=a+dx
    dx=(randrange(1,10)*.0123)*choice([-1,1]) #will never be =0 #change to a more randomly generated float?
    a2=(a+dx).n(digits=4)

    # dave: let d2_ineq = True for '>', False/None for '<'?
    # dave: similarly loc_ineq = True means dx > 0
    # mere: work backwards:
    #            flip coin for too small/too large,
    #            then check dx pos or neg based on how it was found above,
    #            then assign d2_ineq based on
    #                too small:
    #                    dx pos: -> d2_ineq = < or False #you'll need to input the proper strings idk what they are for xml
    #                    dx neg: -> d2_ineq = > or True
    #                too big:
    #                    dx pos: -> d2_ineq = > or True #double check these to make sure I'm not full of lies
    #                    dx neg: -> d2_ineq = < or False

    esterror=choice([True,False]) #True for too small, False for too large
    if(esterror): #probably a prettier if/else thing, but *shrug*
        phrase="too small"
        if(dx > 0):
            d2_ineq = False  #p''<0  #possibly easier to set strings here that will become the appropriate symbol?
            loc_ineq = True #x>a    # then just return "d2_ineq": d2_ineq, and similar for loc_ineq?
        else:
            d2_ineq = True #p''>0
            loc_ineq = False #x<a
    else:
        phrase = "too large"
        if(dx > 0):
            d2_ineq = True  #p''>0
            loc_ineq = True #x>a
        else:
            d2_ineq= False #p''<0
            loc_ineq = False #x<a

###################################
    return {
      "a": a,
      "L": linefunc(x),
      "La": linefunc(a),
      "Lpa": m,
      "adx": a2,
      "Ladx": round(linefunc(a2),4),
      "error": phrase,
      "d2_ineq": ">" if d2_ineq else "<",
      "d2_comp": "<" if d2_ineq else ">",
      "loc_ineq": ">" if loc_ineq else "<",
      "loc_comp": "<" if loc_ineq else ">"
    }
