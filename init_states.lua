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

    ang = 0

    ship = {}
    ship.x = 50
    ship.y = 50
    ship.xspeed = 0
    ship.yspeed = 0
    ship.spr = 64
    ship.sprx = -6
    ship.spry = -5
    ship.w = 2
    ship.h = 2
    ship.flame = 6
    ship.xb = 2
    ship.yb = 2

    laser = { on = false, x = 0, y = ship.y, xb = 0, yb = 0, dmg = 0.4, height = 0, off_timer = 0, collide = false, meter = 100 }
    laser_spr_ind = 0
    laser_spr_num = { 128, 144, 160, 176 }
    laser_start = {
        x = 0,
        y = 0,
        sprx = -12,
        spry = -18,
        spr = 130,
        ani = { 130, 162 },
        frame = 1,
        ani_spd = 0.6,
        w = 3,
        h = 2
    }
    laser_end = {
        x = 0,
        y = 0,
        sprx = -6,
        spry = -10,
        spr = 130,
        ani = { 133, 136 },
        frame = 1,
        ani_spd = 0.6,
        w = 3,
        h = 3
    }

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
        local asteroid = { x = rnd(127), y = -30, sprx = 0, spry = 0, w = 1, h = 1, speed = rnd(0.5) + 0.05, spr = 48 }
        add(asteroids, asteroid)
    end

    bullets = {}
    fire_rate = 3
    delay_next_shot = 0

    enemies = {}
    enemy_bullets = {}

    smart_enemies = {
        -- { "popcorn, 20,-40,30", "mv,25,30,0.4", "st,1000" },
        -- { "popcorn, 40,-30,30","fire,60", "mv,120,120", "st,100" },
        {{ "basic, 20,30,30", "mv,65,50", "st,100","mv, 120,120" },{"st,60", "fire,400", "stop_fire,100"}}
        -- { "basic, 30, -20,30", "mv,55,50","mv, 100,50","fire,60", "st,1000" },
        -- { "tenta1, 75,-20,60","fire,30", "mv,75,30", "st,1000" },

        -- { "popcorn, 80,-10,30", "mv,85,60", "st,1000" },
        -- { "popcorn, 40,-20,30", "mv,45,50", "st,1000" },
        -- { "popcorn, 30,-30,30", "mv,35,40", "st,1000" },
        -- { "popcorn, 20,-40,30", "mv,25,30", "st,1000" },
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