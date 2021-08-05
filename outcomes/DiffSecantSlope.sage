def generator():
    base = randrange(-3, 3)
    baseval = (randrange(0, 4) + randrange(1, 5) / 10)*choice([-1, 1])
    increment = base + (choice([1,2,4,5]) / 10)*choice([-1, 1])
    incrementval = baseval + randrange(1,10)*choice([-1,1]) / 10 


    return {
      "base": base,
      "baseval": format(n(baseval), '.1f'),
      "increment": format(n(increment), '.1f'),
      "incrementval": format(n(incrementval), '.1f'),
      "secantslope": format(n((incrementval - baseval)/(increment - base)), '.2f'),
    }
