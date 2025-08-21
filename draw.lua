function draw_start()
    cls(0)
    starfield()

    print("bark bark", 50, 40, 3)
    print("press action button to start", 15, 60, 10)
end

function draw_over()
    cls(2)

    print("game over", 20, 40, 6)
    print("press action button to start again", 15, 60, 5)
end

function draw_wave_text()
    draw_game()
    print("wave " .. wave, 54, 40, blink())
end

function draw_win()
    cls(2)
    print("victiore ", 54, 40, 15)
end

function draw_game()
    cls(0)

    draw_asteroids()
    starfield()

    if invul <= 0 then
        draw_obj(ship)
        spr(flr(ship.flame), ship.x + ship.spx + 4, ship.y + ship.spy + 10)
    else
        if sin(t / 10) < -0.2 then
            draw_obj(ship)
            spr(flr(ship.flame), ship.x + ship.spx + 4, ship.y + ship.spy + 10)
        end
    end

    for en in all(enemies) do
        if en.flash > 0 then
            en.flash -= 1
            pal(7, 6)
            pal(11, 12)
            pal(10, 13)
        end
        draw_obj(en)
        pal(0)
    end

    draw_array(bullets)

    for bul in all(bullets) do
        draw_obj(bul)
        if bul.muz_flash > 0 then
            circfill(bul.muz_x, bul.muz_y, bul.muz_flash, 8)
        end
        bul.muz_flash -= 1
    end

    draw_laser()

    -- draw particles
    for p in all(particles) do
        circfill(p.x, p.y, p.size, p.color)
    end
    for s in all(shocks) do
        circ(s.x, s.y, s.size, 4)
        s.size += s.rate
        s.age += 1
        if s.age >= s.maxage then
            del(shocks, s)
        end
    end

    for imp in all(impacts) do
        if imp.age < 3 then
            oval(imp.x, imp.y, imp.x1, imp.y1, 9)
        elseif imp.age < 4 then
            oval(imp.x, imp.y, imp.x1, imp.y1, 9)
            oval(imp.x - 1, imp.y - 1, imp.x1 + 1, imp.y1 - 1, 10)
        else
            oval(imp.x - 1, imp.y - 1, imp.x1 + 1, imp.y1 - 1, 10)
        end
    end

    for sp in all(sparks) do
        pset(sp.x, sp.y, 4)
        sp.x += sp.sx
        sp.y += sp.sy
        sp.age += 1
        if sp.age >= sp.maxage then
            del(sparks, sp)
        end
    end

    -- UI
    print(score, 5 , 5, 3)

    print(wave.."/"..max_num_wave-1,5,15,11)

    for i = 0, 2 do
        if lives > 2 - i then
            pal(1,10)
            spr(9, 5, i * 6 + 105)
            pal(0)
        else
            spr(9, 5, i * 6 + 105)
        end
    end

    if bombs==1 then
        spr(25,12, 110)
    end

    draw_laser_meter()

    draw_all_hitbox()
end

function draw_asteroids()
    for asteroid in all(asteroids) do
        draw_obj(asteroid)
    end
end

function starfield()
    for star in all(stars) do
        if star.speed < 1.8 then
            pset(star.x, star.y, star.color)
        else
            line(star.x, star.y, star.x, star.y - 2, star.color)
        end
    end
end

function create_stars()
    stars = {}
    for i = 0, 80 do
        local star = {}
        local color

        star.x = flr(rnd(128))
        star.y = flr(rnd(128))
        star.speed = rnd(2)

        if star.speed <= 0.3 then
            color = 1
        end
        if star.speed > 0.3 and star.speed < 1 then
            color = 2
        elseif star.speed >= 1 then
            color = 4
        end
        star.color = color
        add(stars, star)
    end
end

function draw_all_hitbox()
    if show_hb_flag then
        draw_hb(ship)

        if laser.on then
            draw_hb(laser)
        end

        for en in all(enemies) do
            draw_hb(en)
        end
        for b in all(bullets) do
            draw_hb(b)
        end
    end
end

function animate_stars()
    for star in all(stars) do
        star.y = (star.y + star.speed) % 127
    end
end

function update_asteroids()
    for asteroid in all(asteroids) do
        asteroid.y = asteroid.y + asteroid.speed
        if asteroid.y > 127 then
            asteroid.y = rnd(40) - 40
            asteroid.speed = rnd(0.5)
            asteroid.x = rnd(127)
        end
    end
end

function update_expl()
    for p in all(particles) do
        p.x += p.sx
        p.y += p.sy
        p.age += 1

        local newsize = p.size - p.rate
        if p.fission >= 3 and p.size >= p.fission and newsize <= p.fission then
            for i = 1, 8 do
                local pc = create_p(p.x, p.y)
                pc.size = rnd(p.size)
                pc.rate = 0.1 + rnd(0.4)
                pc.fission = pc.size / 1.5
                pc.color = 1
                add(particles, pc)
            end
        end

        p.size = newsize
        if p.age > p.maxage or p.size < 1 then
            del(particles, p)
        end
    end
end

function create_p(x, y)
    local p = {}
    p.x = x + rnd(10) - 5
    p.y = y + rnd(10) - 5
    p.sx = rnd(1) - 0.5
    p.sy = rnd(1) - 0.5
    p.size = 5 + rnd(10)
    p.rate = 0.3 + rnd(0.5)
    p.age = 0
    p.maxage = 10 + rnd(30)
    p.fission = p.size / 2
    rndc = rnd(2)
    if rndc < 1 then
        p.color = 9
    else
        p.color = 8
    end

    return p
end

function explode(x, y)
    for i = 1, 4 do
        add(particles, create_p(x, y))
    end
    for i = 1, 20 do
        local p = {}
        p.x = x
        p.y = y
        p.sx = rnd(4) - 2
        p.sy = rnd(4) - 2
        p.age = 0
        p.maxage = 5 + rnd(20)
        add(sparks, p)
    end

    local s = {}
    s.x = x
    s.y = y
    s.size = 0
    s.age = 0
    s.maxage = 10 + rnd(20)
    s.rate = 0.5 + rnd(0.5)
    add(shocks, s)
end

function draw_laser()
    if laser.on then
        max_num_sprite = flr(laser.height / 8)
        incomplete_sprite = laser.height % 8

        laser_spr_ind = mod(laser_spr_ind + 0.5, 4, 1)
        local floored = flr(laser_spr_ind)
        for i = 0, max_num_sprite - 1 do
            spr(laser_spr_num[mod(floored + i, 4, 1)], laser.x - 3, laser.y + 8 * i, 2, 1)
        end
        clip(laser.x - 3, laser.y + 8 * max_num_sprite, 30, incomplete_sprite)
        spr(laser_spr_num[mod(floored + max_num_sprite, 4, 1)], laser.x - 3, laser.y + 8 * max_num_sprite, 2, 1)
        clip()
    end
end

function draw_laser_meter()
    print(laser.meter, 12, 95, 13)
    local norm_meter = laser.meter / 100
    rectfill(5, 100 - norm_meter * 60, 10, 100, 13)
end