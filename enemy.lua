function spawn_wave()
end

function load_enemy(enemy_table)
    local en = {}
    local spawn = split(enemy_table[1])

    en.type = spawn[1]
    en.x = spawn[2]
    en.y = spawn[3]
    en.spawn_timer = spawn[4]
    en.flash = 0
    en.i = 1
    en.seq_len = #enemy_table - 1

    if en.type == "popcorn" then
        en.spr = 35
        en.spx = 0
        en.spy = 0
        en.spd = 0.4
        en.w = 1
        en.h = 1
        en.hp = 20
        en.xb = 8
        en.yb = 8
        en.delay_shot = 0
        en.fire_state = "fire"
        en.update_canon = update_popcorn_canon
    end

    if en.type == "tenta1" then
        en.spr = 37
        en.spx = 0
        en.spy = 0
        en.spd = 0.3
        en.w = 2
        en.h = 2
        en.hp = 20
        en.xb = 13
        en.yb = 13
        en.delay_shot = 0
        en.fire_state = "fire"
        en.update_canon = update_tenta1_canon
    end

    local seq = {}
    for i = 2, #enemy_table do
        print(i)
        local action = split(enemy_table[i])
        if action[1] == "mv" then
            local spx = (action[2] - en.x)
            local spy = (action[3] - en.y)
            n_frame = flr(sqrt(spx * spx + spy + spy) / en.spd)
            add(
                seq, {
                    type = "move",
                    start_x = en.x,
                    start_y = en.y,
                    dest_x = action[2],
                    dest_y = action[3],
                    t = linspace(n_frame),
                    index_t = 1,
                    end_index = n_frame + 1
                }
            )
        elseif action[1] == "st" then
            add(seq, { type = "standby", t = action[2] })
        end
    end
    en.seq = seq
    add(spawn_list, en)
end

function check_spawns()
    for en in all(spawn_list) do
        if t >= en.spawn_timer then
            add(enemies, en)
            del(spawn_list, en)
        end
    end
end

function update_enemy()
    for en in all(enemies) do
        if en.i > en.seq_len then
            -- dont despawn enemy FOR TESTS
            -- del(enemies, en)
        else
            action = en.seq[en.i]
            if action.type == "move" then
                if action.index_t == action.end_index then
                    en.i += 1
                else
                    en.x = lerp(
                        action.start_x,
                        action.dest_x,
                        action.t[action.index_t]
                    )
                    en.y = lerp(
                        action.start_y,
                        action.dest_y,
                        action.t[action.index_t]
                    )
                    action.index_t += 1
                end
            elseif action.type == "standby" then
                if t >= action.t then
                    en.i += 1
                end
            end
        end
    end
end

function update_enemy_fire()
    for en in all(enemies) do
        if en.fire_state == "fire" then
            if en.delay_shot <= 0 then
                en.update_canon(en)
            else
                en.delay_shot -= 1
            end
        end
    end
end

function update_enemy_bullets()
    for en_bul in all(enemy_bullets) do
        en_bul.x += en_bul.spx
        en_bul.y += en_bul.spy
    end
end