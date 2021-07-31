def generator():
    t=var("t")
    position = sum([
            randrange(4-i,10-2*i)*choice([-1,1])*t^i
            for i in range(1,4)
        ])+randrange(10,99)*choice([-1,1])
    elapsed_time = randrange(3,7)
    units = choice(
        [
            "meters",
            "feet",
            "yards",
            "miles",
            "kilometers",
        ]
    )
    return {
        "position": position,
        "elapsed": {
            "time": elapsed_time,
            "position": position(t=elapsed_time),
            "displacement": position(t=elapsed_time)-position(t=0),
            "velocity": position.diff()(t=elapsed_time),
            "speed": abs(position.diff()(t=elapsed_time)),
            "acceleration": position.diff().diff()(t=elapsed_time),
        },
        "units": units,
    }