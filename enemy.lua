function spawn_wave()
end

function load_enemy(enemy_table)
    local en = {}
    local action_table = enemy_table[1]
    local fire_table = enemy_table[2]
    local spawn = split(action_table[1])

    local seq = {}
    local fire_seq = {}

    add(seq, { type = "standby", duration = spawn[4], func = standby })
    en.type = spawn[1]
    en.x = spawn[2]
    en.y = spawn[3]
    en.spawn_timer = spawn[4]
    en.flash = 0
    en.i = 1
    en.t = 0
    en.seq_len = #action_table - 1
    en.t_fire = 0
    en.i_fire = 1

    if en.type == "popcorn" then
        en.spr = 35
        en.sprx = 0
        en.spry = 0
        en.spd = 0.4
        en.w = 1
        en.h = 1
        en.hp = 20
        en.xb = 8
        en.yb = 8
        en.delay_shot = 0
        en.fire_state = "stop_fire"
        en.update_canon = nil
    elseif en.type == "basic" then
        en.spr = 36
        en.sprx = 0
        en.spry = 0
        en.spd = 0.35
        en.w = 1
        en.h = 1
        en.hp = 20
        en.xb = 8
        en.yb = 8
        en.delay_shot = 0
        en.fire_state = "stop_fire"
        en.update_canon = update_basic_canon
    elseif en.type == "tenta1" then
        en.spr = 37
        en.sprx = 0
        en.spry = 0
        en.spd = 0.3
        en.w = 2
        en.h = 2
        en.hp = 10000
        en.xb = 13
        en.yb = 13
        en.delay_shot = 0
        en.fire_state = "stop_fire"
        en.update_canon = update_tenta1_canon
    end

    for i = 2, #action_table do
        local action = split(action_table[i])
        if action[1] == "mv" then
            local spx = (action[2] - en.x)
            local spy = (action[3] - en.y)
            local n_frame = flr(sqrt(spx * spx + spy + spy) / en.spd)
            add(
                seq, {
                    type = "move",
                    start_x = 0,
                    start_y = 0,
                    dest_x = action[2],
                    dest_y = action[3],
                    t = linspace(n_frame),
                    last_t = n_frame,
                    func = lerp_enemy
                }
            )
        elseif action[1] == "st" then
            add(seq, { type = "standby", duration = action[2] - 1, func = standby })

        end
    end
    add(
        seq, {
            type = "despawn",
            func = despawn_enemy
        }
    )

    for i = 1, #fire_table do
        local action = split(fire_table[i])
        if action[1] == "st" then
            add(fire_seq, { type = "standby", duration = action[2] - 1, func = standby_fire })
        elseif action[1] == "fire" or action[1] == "stop_fire" then
            add(
                fire_seq, {
                    fire_state = action[1],
                    func = change_fire_state
                }
            )
            add(fire_seq, { type = "standby", duration = action[2] - 1, func = standby_fire })
        end
    end

    en.seq = seq
    en.fire_seq = fire_seq
    add(enemies, en)
end

function lerp_enemy(en, command)
    if en.t == 0 then
        command.start_x = en.x
        command.start_y = en.y
    end
    if en.t < command.last_t then
        en.x = lerp(
            command.start_x,
            command.dest_x,
            easeoutquad(command.t[en.t + 1])
        )
        en.y = lerp(
            command.start_y,
            command.dest_y,
            easeoutquad(command.t[en.t + 1])
        )
    else
        return true
    end
    return false
end

function standby(en, command)
    return standby_helper(en.t, command.duration)
end

function standby_fire(en,command)
    return standby_helper(en.t_fire, command.duration)
end

function standby_helper(t, duration)
    if t == duration then
        return true
    end
    return false
end

function change_fire_state(en, command)
    en.fire_state = command.fire_state
    return true
end

function despawn_enemy(en, command)
    del(enemies, en)
end

function update_enemy_bullets()
    for en_bul in all(enemy_bullets) do
        en_bul.x += en_bul.spx
        en_bul.y += en_bul.spy
    end
end