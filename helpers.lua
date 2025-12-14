function draw_obj(obj)
    spr(obj.spr, obj.x + obj.sprx, obj.y + obj.spry, obj.w, obj.h)
end

function draw_array(array)
    for obj in all(array) do
        draw_obj(obj)
    end
end

function draw_hb(obj,color)
    color = color or 5
    rect(obj.x, obj.y, obj.x + obj.xb, obj.y + obj.yb, color)
end

function mod(a, n, d)
    -- a modulo n offset d
    return a - n * flr((a - d) / n)
end

function col(a, b)
    local a_left = a.x
    local a_right = a.x + a.xb
    local a_top = a.y
    local a_bottom = a.y + a.yb

    local b_left = b.x
    local b_right = b.x + b.xb
    local b_top = b.y
    local b_bottom = b.y + b.yb

    if a_right < b_left then return false end
    if a_left > b_right then return false end
    if a_top > b_bottom then return false end
    if a_bottom < b_top then return false end

    return true
end

function blink()
    local banim = { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 1, 1, 2, 2, 3 }
    if blinkt > #banim then
        blinkt = 1
    end
    return banim[blinkt]
end

function lerp(a, b, t)
    local ret
    if t == 1 then
        ret = b
    else
        ret = a + (b - a) * t
    end
    return ret
end

function linspace(num_points)
    local array = {}
    for i = 1, num_points do
        array[i] = i / num_points
    end
    -- fixme doesnt start at 0
    return array
end


-- qsort(a,c,l,r)
--
-- a
--    array to be sorted,
--    in-place
-- c
--    comparator function(a,b)
--    (default=return a<b)
-- l
--    first index to be sorted
--    (default=1)
-- r
--    last index to be sorted
--    (default=#a)
--
-- typical usage:
--   qsort(array)
--   -- custom descending sort
--   qsort(array,function(a,b) return a>b end)
--
function qsort(a, c, l, r)
    c, l, r = c or function(a, b) return a < b end, l or 1, r or #a
    if l < r then
        if c(a[r], a[l]) then
            a[l], a[r] = a[r], a[l]
        end
        local lp, k, rp, p, q = l + 1, l + 1, r - 1, a[l], a[r]
        while k <= rp do
            local swaplp = c(a[k], p)
            -- "if a or b then else"
            -- saves a token versus
            -- "if not (a or b) then"
            if swaplp or c(a[k], q) then
            else
                while c(q, a[rp]) and k < rp do
                    rp -= 1
                end
                a[k], a[rp], swaplp = a[rp], a[k], c(a[rp], p)
                rp -= 1
            end
            if swaplp then
                a[k], a[lp] = a[lp], a[k]
                lp += 1
            end
            k += 1
        end
        lp -= 1
        rp += 1
        -- sometimes lp==rp, so
        -- these two lines *must*
        -- occur in sequence;
        -- don't combine them to
        -- save a token!
        a[l], a[lp] = a[lp], a[l]
        a[r], a[rp] = a[rp], a[r]
        qsort(a, c, l, lp - 1)
        qsort(a, c, lp + 1, rp - 1)
        qsort(a, c, rp + 1, r)
    end
end

function sort_seq(a,b)
    return a.start_time < b.start_time
end

function easeoutquad(t)
	t-=1
	return 1-t*t
end


-- pq by pancelor: lexaloffle.com/bbs/?tid=42367
function pq(...)printh(qq(...))return...end
function qq(...)local r=""for i=1,select("#",...)do r..=_q(select(i,...),4).." "end return r end
function _q(t,d)if(type(t)~="table"or d<=0)return tostr(t)
local r="{"for k,v in next,t do r..=tostr(k).."=".._q(v,d-1)..","end return r.."}"end