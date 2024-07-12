local cairo = require 'oocairo'
local quad = require 'quad'

local function draw(wall)
    local min, max = wall:GetMinMax()

    local img = cairo.image_surface_create("rgb24", max.x + min.x, max.y + min.y)
    local cr = cairo.context_create(img)
    cr:set_source_rgb(1, 1, 1)
    cr:paint()

    local tiles = wall:TileSquares(12, 12, 7)
    for _, v in ipairs(tiles) do
        v:Draw(cr)
    end

    local err = img:write_to_png("wall.png")
end

local wall = quad.new(
    {x = 10, y = 10},
    {x = 110, y = 10},
    {x = 10, y = 110},
    {x = 110, y = 110}
)

draw(wall)

