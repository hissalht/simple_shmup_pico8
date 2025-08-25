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
    max_num_wave = 4
    next_wave()

    ship = {}
    ship.x = 64
    ship.y = 64
    ship.xspeed = 0
    ship.yspeed = 0
    ship.spr = 64
    ship.spx = -3
    ship.spy = -2.5
    ship.w = 2
    ship.h = 2
    ship.flame = 6
    ship.xb = 2
    ship.yb = 2

    laser = { on = false, x = 0, y = ship.y, xb = 0, yb = 0, dmg = 0.4, height = 0, off_timer = 0, collide = false, meter = 100 }
    laser_spr_ind = 0
    laser_spr_num = { 128, 144, 160, 176 }

    speed_bul = 5

    score = 69
    lives = 3
    bombs = 1

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
    fire_rate = 6
    delay_next_shot = 0

    enemies = {}

    smart_enemies = {
        { "popcorn, 10,-20,20", "mv,10,40,30", "st,300" },
        { "popcorn, 20,-40,20", "mv,20,40,30", "st,300" },
        { "popcorn, 30,-50,20", "mv,30,40,30", "st,300" },
        { "popcorn, 20,-60,20", "mv,20,40,30", "st,300" },
        { "popcorn, 10,-70,20", "mv,10,40,30", "st,300" },
        { "popcorn, 5,-80,20", "mv,5,40,30", "st,300" },
    }
    spawn_list = {}
    for en_descr in all(smart_enemies) do
        load_enemy(en_descr)
    end

    particles = {}
    shocks = {}
    impacts = {}
    sparks = {}
end