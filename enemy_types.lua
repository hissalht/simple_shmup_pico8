function update_popcorn_canon(en)
    local bul = {}
    bul.x = en.x + 0
    bul.y = en.y + 1
    bul.xb = 1
    bul.yb = 1
    bul.dmg = 1
    bul.spr = 10
    bul.ani = {10,11,12}
    bul.frame = 1
    bul.ani_spd = 0.3
    bul.w = 1
    bul.h = 1
    local atantruc = atan2(ship.x - bul.x, ship.y - bul.y)
    bul.spx = cos(atantruc) * 1.5
    bul.spy = sin(atantruc) * 1.5
    add(enemy_bullets, bul)
    en.delay_shot = 60
end

function update_tenta1_canon(en)
    -- random circular shot, occupy space
    for i = 1, 10 do
        local theta = rnd()
        for j = 1, 4 do
            local bul = {}
            bul.x = en.x + j * 2 * cos(theta)
            bul.y = en.y + j * 2 * sin(theta)
            bul.xb = 1
            bul.yb = 1
            bul.dmg = 1
            bul.spr = 10
            bul.ani = {10,11,12}
            bul.frame = 1
            bul.ani_spd = 0.3
            bul.w = 1
            bul.h = 1
            bul.spx = cos(theta) * 1
            bul.spy = sin(theta) * 1
            add(enemy_bullets, bul)
        end
    end
    en.delay_shot = 120

    -- target player double shot
    local offset_theta = { 0.025, -0.025 }
    for j = 1, 2 do
        local bul = {}
        bul.x = en.x + 8
        bul.y = en.y + 1
        bul.xb = 1
        bul.yb = 1
        bul.dmg = 1
        bul.spr = 10
        bul.ani = {10,11,12}
        bul.frame = 1
        bul.ani_spd = 0.3
        bul.w = 1
        bul.h = 1
        local atantruc = atan2(ship.x - bul.x, ship.y - bul.y)
        bul.spx = cos(atantruc + offset_theta[j]) * 1
        bul.spy = sin(atantruc + offset_theta[j]) * 1
        add(enemy_bullets, bul)
    end
end