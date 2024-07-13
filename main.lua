local cairo = require 'oocairo'
local quad = require 'quad'

local function getNeighbouringQuads(tiles, width)
    local quads = {}
    for _, v in ipairs(tiles) do
        for _, k in ipairs(v.quads) do
            table.insert(quads, k)
        end
    end

    local function getLeftPosition(i)
        local row = math.ceil(i / width)
        local reverse = row % 2 == 0
        local left = reverse and 1 or -1
        if ((i + (reverse and 0 or - 1)) % width) ~= 0 then
            return i + left
        else return nil end
    end

    local function getRightPosition(i)
        local row = math.ceil(i / width)
        local reverse = row % 2 == 0
        local right = reverse and - 1 or 1
        if ((i + (reverse and -1 or 0)) % width) ~= 0 then
            return i + right
        else return nil end
    end

    local maxRow = math.ceil(#quads / width)
    for i, q in ipairs(quads) do
        local row = math.ceil(i / width)

        local sameTileCount = 0
        if row ~= 1 then
            local position = ((((row - 1) * 2) * width) + 1) - i

            sameTileCount = sameTileCount + q:SetNeighbour("tm", quads[position])
            local tr = getRightPosition(position)
            if tr ~= nil then
                sameTileCount = sameTileCount + q:SetNeighbour("tr", quads[tr])
            end
            local tl = getLeftPosition(position)
            if tl ~= nil then
                sameTileCount = sameTileCount + q:SetNeighbour("tl", quads[tl])
            end
        end
        if row ~= maxRow then
            local position = (((row * 2) * width) + 1) - i

            sameTileCount = sameTileCount + q:SetNeighbour("bm", quads[position])
            local br = getRightPosition(position)
            if br ~= nil then
                sameTileCount = sameTileCount + q:SetNeighbour("br", quads[br])
            end
            local bl = getLeftPosition(position)
            if bl ~= nil then
                sameTileCount = sameTileCount + q:SetNeighbour("bl", quads[bl])
            end
        end

        local ml = getLeftPosition(i)
        if ml ~= nil then
            sameTileCount = sameTileCount + q:SetNeighbour("ml", quads[ml])
        end
        local mr = getRightPosition(i)
        if mr ~= nil then
            sameTileCount = sameTileCount + q:SetNeighbour("mr", quads[mr])
        end

        if sameTileCount >= 2 then
            q.movable = true
        end
    end
end

local function draw(wall)
    local min, max = wall:GetMinMax()

    local img = cairo.image_surface_create("rgb24", max.x + min.x, max.y + min.y)
    local cr = cairo.context_create(img)
    cr:set_source_rgb(1, 1, 1)
    cr:paint()

    local tiles = wall:TileSquares(5, 12, 5)

    getNeighbouringQuads(tiles, 12)

    for _, tile in ipairs(tiles) do
        tile:Draw(cr)
    end

    local err = img:write_to_png("wall.png")

    for _, tile in ipairs(tiles) do
        local neighbouringTiles = {}
        for _, v in ipairs(tile.quads) do
            for _, k in pairs(v.neighbours) do
                if k ~= nil and k ~= tile then
                    if neighbouringTiles[k.tile] == nil then
                        neighbouringTiles[k.tile] = 1
                    else
                        neighbouringTiles[k.tile] = neighbouringTiles[k.tile] + 1
                    end
                end
            end
        end
        
        
        for k, v in pairs(neighbouringTiles) do
            if v >= 2 then
                local random = math.random(4)
                if random == 1 then
                    for _, q in pairs(tile.quads) do
                        for _, q2 in pairs(k.quads) do
                            if q.movable and q2.movable then
                                tile:SwapQuad(q, q2)
                                goto exit
                            end
                        end             
                    end
                end
            end
        end
        ::exit::
    end

    for _, v in pairs(tiles) do
        v:Draw(cr)
    end

    local err = img:write_to_png("wall2.png")
end

local wall = quad.new(
    {x = 10, y = 10},
    {x = 110, y = 10},
    {x = 10, y = 110},
    {x = 110, y = 110}
)

draw(wall)

