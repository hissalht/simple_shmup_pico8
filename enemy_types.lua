bul_spr_settings = {
    frames = { 10, 11, 12 },
    frame = 1,
    start = 1,
    stop = 3,
    speed = 0.3,
    loop = true,
    dir = 1,
    w = 1,
    h = 1
}

function update_basic_canon(en)
    local bul = {
        x = en.x,
        y = en.y + 1,
        xb = 1,
        yb = 1,
        dmg = 1,
        spr_settings = {}
    }
    add(bul.spr_settings, bul_spr_settings)
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
            bul.xb = 3
            bul.yb = 3
            bul.dmg = 1
            bul.spr = 10
            bul.sprx = -1
            bul.spry = -1
            add(bul, bul_spr_settings)
            bul.w = 1
            bul.h = 1
            bul.spx = cos(theta) * 1
            bul.spy = sin(theta) * 1
            add(enemy_bullets, bul)
        end
    end
    en.delay_shot = 100

    -- target player double shot
    local offset_theta = { 0.025, -0.025 }
    for j = 1, 2 do
        local bul = {}
        bul.x = en.x + 8
        bul.y = en.y + 1
        bul.xb = 3
        bul.yb = 3
        bul.dmg = 1
        add(bul, bul_spr_settings)
        local atantruc = atan2(ship.x - bul.x, ship.y - bul.y)
        bul.spx = cos(atantruc + offset_theta[j]) * 1
        bul.spy = sin(atantruc + offset_theta[j]) * 1
        add(enemy_bullets, bul)
    end
end