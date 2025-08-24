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
smart_enemies = {
    { { "popcorn,90,50,30" }, { "mv,40,40,100", "st,90" } }
}

function spawn_enemy(type, x, y,seq)
    local en = {}
    if type == "popcorn" then
        en.spr = 35
        en.spx = 0
        en.spy = 0
        en.w = 1
        en.h = 1
        en.hp = 3
        en.xb = 8
        en.yb = 8
    end

    en.flash = 0
    en.x = x
    en.y = y
    en.seq = seq
    en.i = 1

    add(enemies, en)
end

function check_spawns()
    for en in all(smart_enemies) do
        local spawn = split(en[1][1])
        if t >= spawn[4] then
            spawn_enemy(spawn[1], spawn[2], spawn[3], en[2])
            del(smart_enemies, en)
        end
    end
end

function update_enemy()

    for en in all(enemies) do
        -- filter out old enemies for now
        if en.seq then
            cmd = split(en.seq[en.i])
            if cmd[1] == "mv" then
                if en.x == cmd[2] and en.y == cmd[3] then
                    en.i += 1
                else
                    en.spx = (cmd[2]- en.x) / cmd[4]
                    en.spy = (cmd[3]- en.y) / cmd[4]
                    en.i +=1
                    -- en.x+= 2
                    -- en.y+= 2
                end
            end
        end
    end
end