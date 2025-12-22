bul_spr_settings = {
    frames = { 10, 11, 12 },
    frame = 10,
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
            local bul = {
                x = en.x + j * 2 * cos(theta),
                y = en.y + j * 2 * sin(theta),
                xb = 1,
                yb = 1,
                dmg = 1,
                spr_settings = {},
                spx = cos(theta) * 1,
                spy = sin(theta) * 1,
            }
            add(bul.spr_settings, bul_spr_settings)
            bul.spr_settings[1].sprx = -1
            bul.spr_settings[1].spry = -1
            add(enemy_bullets, bul)
        end
    end
    en.delay_shot = 100

    -- target player double shot
    local offset_theta = { 0.025, -0.025 }
    for j = 1, 2 do
        local bul = {
            x = en.x + 8,
            y = en.y + 1,
            xb = 1,
            yb = 1,
            dmg = 1,
            spr_settings = {},
        }
        add(bul.spr_settings, bul_spr_settings)
        local atantruc = atan2(ship.x - bul.x, ship.y - bul.y)
        bul.spx = cos(atantruc + offset_theta[j]) * 1
        bul.spy = sin(atantruc + offset_theta[j]) * 1
        add(enemy_bullets, bul)
    end
end