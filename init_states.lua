function update_over()
    if btnp(4) or btnp(5) then
        start_game()
    end
end

function update_start()
    animate_stars()
    if btnp(4) or btnp(5) then
        start_game()
    end
end

function start_game()
    wave = 0
    next_wave()

    ship = {}
    ship.x = 64
    ship.y = 64
    ship.xspeed = 0
    ship.yspeed = 0
    ship.spr = 64
    ship.spx = -4
    ship.spy = -5
    ship.w = 2
    ship.h = 2
    ship.flame = 6
    ship.xb = 2
    ship.yb = 2

    speed_bul = 5

    score = 69
    lives = 3
    bombs = 2

    invul = 0

    t = 0
    blinkt = 0

    create_stars()

    asteroids = {}
    for i = 1, 3 do
        local asteroid = { x = rnd(127), y = -30, spx = 0, spy = 0, w = 1, h = 1, speed = rnd(0.5) + 0.05, spr = 48 }
        add(asteroids, asteroid)
    end

    bullets = {}
    fire_rate = 3
    delay_next_shot = 0

    enemies = {}

    particles = {}
    shocks = {}
    impacts = {}
    sparks = {}
end