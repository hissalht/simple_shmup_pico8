function spawn_wave()
end

function load_enemy(enemy_table)
    local en = {}
    local spawn = split(enemy_table[1])

    local seq = {}
    local current_t = spawn[4] + 1

    add(seq, { type = "standby", t = spawn[4], start_time = 0, func = standby })
    add(
        seq,
        {
            type = "spawn",
            start_time = spawn[4]
        }
    )

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

    for i = 2, #enemy_table do
        local action = split(enemy_table[i])
        if action[1] == "mv" then
            local spx = (action[2] - en.x)
            local spy = (action[3] - en.y)
            local n_frame = flr(sqrt(spx * spx + spy + spy) / en.spd)
            add(
                seq, {
                    type = "move",
                    start_x = en.x,
                    start_y = en.y,
                    dest_x = action[2],
                    dest_y = action[3],
                    t = linspace(n_frame),
                    index_t = 1,
                    end_index = n_frame + 1,
                    start_time = current_t,
                    func = lerp_enemy
                }
            )
            current_t += n_frame + 1
        elseif action[1] == "st" then
            add(seq, { type = "standby", t = action[2], start_time = current_t, func = standby })
            current_t += action[2] + 1
        elseif action[1] == "fire" then
            add(
                seq, {
                    type = "fire",
                    start_time = action[2]
                }
            )
        elseif action[1] == "stop_fire" then
            add(
                seq, {
                    type = "stop_fire",
                    start_time = action[2]
                }
            )
        end
    end

    add(
        seq, {
            type = "despawn",
            start_time = current_t
        }
    )

    qsort(seq, sort_seq)
    pq(seq)

    en.seq = seq
    add(spawn_list, en)
end

function lerp_enemy(en, command)
    if command.index_t != command.end_index then
        en.x = lerp(
            command.start_x,
            command.dest_x,
            easeoutquad(command.t[command.index_t])
        )
        en.y = lerp(
            command.start_y,
            command.dest_y,
            easeoutquad(command.t[command.index_t])
        )
        command.index_t += 1
    end
end

function standby(en, command)
end

function update_enemy_states()
    for en in all(enemies) do
        next_t = en.seq[en.i]
        -- pq(en.seq[en.i].type)
        if t == next_t then
            en.i += 1
            if en.seq[en.i].type == "fire" then
                en.fire_state = "fire"
            elseif en.seq[en.i].type == "stop_fire" then
                en.fire_state = "stop_fire"
            elseif en.seq[en.i].type == "move" then
                en.state = "move"
            elseif en.seq[en.i].type == "move" then
                en.state = "move"
            elseif en.seq[en.i].type == "stanby" then
                en.state = "standby"
            elseif en.seq[en.i].type == "spawn" then
                en.spawned = true
            end
        end
    end
end

function enemy_routines()
    for en in all(enemies) do
        en.seq[en.i].func(en, en.seq[en.i])
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