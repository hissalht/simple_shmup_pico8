function update_game()
    t += 1
    blinkt += 1
    laser.off_timer -= 1

    ship.xspeed = 0
    ship.yspeed = 0
    ship.spr = 64

    if delay_next_shot > 0 then
        delay_next_shot -= 1
    end

    if laser.off_timer <= 0 then
        laser.height = 0
        laser.on = false
    end
    update_controls()

    update_ship_position()
    ship.flame = mod(ship.flame + 0.12, 3, 6)

    if invul > 0 then
        invul -= 1
    end

    check_spawns()
    update_enemy()

    update_bullets()
    update_collision_laser()

    update_collisions_edges()
    update_collision_ship()

    if mode == "game" then
        update_collision_bullets()
    end

    update_expl()

    if lives <= 0 then mode = "over" end

    animate_stars()

    update_asteroids()
end

function update_wave_text()
    update_game()
    wave_time -= 1
    if wave_time <= 0 then
        mode = "game"
        t = 0
        -- spawn_wave()
    end
end

function update_win()
    if btn(4) == false and btn(5) == false then
        btn_release = true
    end
    if btn_release then
        if btnp(4) or btnp(5) then
            mode = "start"
        end
    end
end

function next_wave()
    wave += 1
    wave_time = 30
    mode = "wave_text"

    if wave == max_num_wave then
        mode = "win"
    end
end

function update_controls()
    if btn(0) then
        ship.xspeed = -1
        ship.spr = 68
    end
    if btn(1) then
        ship.xspeed = 1
        ship.spr = 66
    end
    if btn(2) then
        ship.yspeed = -1
    end
    if btn(3) then
        ship.yspeed = 1
    end
    if btn(4) then
        if laser.meter >= 0 then
            laser.on = true
            laser.meter -= 1
            laser.x = ship.x - 2
            laser.xb = 6
            if laser.collide == false then
                laser.height += 3
            end
            laser.yb = laser.height
            laser.y = ship.y - 8 - laser.height
            laser.off_timer = 8
            sfx(4)
        end
    end
    if btn(5) then
        if delay_next_shot == 0 then
            add(bullets, create_bullet(ship.x + ship.spx + 2, ship.y + ship.spy - 3, 0))
            add(bullets, create_bullet(ship.x + ship.spx + 8, ship.y + ship.spy - 3, 1))
            sfx(0)
            delay_next_shot = fire_rate
        end
    end
end