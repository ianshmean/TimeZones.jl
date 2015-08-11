import Base.Dates: Day, Hour

warsaw = resolve("Europe/Warsaw", tzdata["europe"]...)

# Period arithmetic
normal = DateTime(2015, 1, 1, 0)   # 24 hour day in warsaw
spring = DateTime(2015, 3, 29, 0)  # 23 hour day in warsaw
fall = DateTime(2015, 10, 25, 0)   # 25 hour day in warsaw

@test ZonedDateTime(normal, warsaw) + Day(1) == ZonedDateTime(normal + Day(1), warsaw)
@test ZonedDateTime(spring, warsaw) + Day(1) == ZonedDateTime(spring + Day(1), warsaw)
@test ZonedDateTime(fall, warsaw) + Day(1) == ZonedDateTime(fall + Day(1), warsaw)

@test ZonedDateTime(normal, warsaw) + Hour(24) == ZonedDateTime(normal + Hour(24), warsaw)
@test ZonedDateTime(spring, warsaw) + Hour(24) == ZonedDateTime(spring + Hour(25), warsaw)
@test ZonedDateTime(fall, warsaw) + Hour(24) == ZonedDateTime(fall + Hour(23), warsaw)

# Non-Associativity
hour_day = (ZonedDateTime(spring, warsaw) + Hour(24)) + Day(1)
day_hour = (ZonedDateTime(spring, warsaw) + Day(1)) + Hour(24)

@test hour_day - day_hour == Hour(1)
