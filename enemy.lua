-- old system

-- function update_enemies()
--     for enemy in all(enemies) do
--         enemy.y += 0.4
--         enemy.spr = mod(enemy.spr + 0.1, 3, 32)
--     end
-- end

function spawn_wave()
    for i = 1, 8 do
        local en = {}
        en.x = i * 10 + 5
        en.y = 20
        en.spx = 0
        en.spy = 0
        en.spr = 35 + flr(rnd(2))
        en.w = 1
        en.h = 1
        en.hp = 10
        en.xb = 8
        en.yb = 8
        en.flash = 0
        add(enemies, en)
    end
end

-- new enemy system

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
        en.w = 1
        en.h = 1
        en.hp = 3
        en.xb = 8
        en.yb = 8
    end

    local seq = {}
    for i = 2, #enemy_table do
        print(i)
        local action = split(enemy_table[i])
        if action[1] == "mv" then
            local spx = (action[2] - en.x) / action[4]
            local spy = (action[3] - en.y) / action[4]
            add(seq, { type = "move", dest_x = action[2], dest_y = action[3], spx = spx, spy = spy })
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
        -- filter out old enemies for now
        if en.seq then
            if en.i > en.seq_len then
                del(enemies, en)
            else
                action = en.seq[en.i]
                if action.type == "move" then
                    if abs(en.x - action.dest_x) < 0.05 and abs(en.y - action.dest_y) < 0.05 then
                        en.i += 1
                    else
                        en.x += action.spx
                        en.y += action.spy
                    end
                elseif action.type == "standby" then
                    if t >= action.t then
                        en.i += 1
                    end
                end
            end
        end
    end
end