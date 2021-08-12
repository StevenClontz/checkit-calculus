def generator():
    fencing = 20*randrange(4,31)
    units = choice(["feet", "meters", "yards"])
    area = fencing^2/8
    scenario = choice(["garden", "corral"])
    return {
        "fencing": fencing,
        "units": units,
        "area": area,
        scenario: True,
    }