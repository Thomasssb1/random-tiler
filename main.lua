local cairo = require 'oocairo'
local quad = require 'quad'

local function draw(wall)
    local min, max = wall:GetMinMax()

    local img = cairo.image_surface_create("rgb24", max.x + min.x, max.y + min.y)
    local cr = cairo.context_create(img)
    cr:set_source_rgb(1, 1, 1)
    cr:paint()

    --wall:Draw(cr)
    wall:TileSquares(cr, 10, 10, 5)

    local err = img:write_to_png("wall.png")
end

local wall = quad.new(
    {x = 10, y = 10},
    {x = 110, y = 10},
    {x = 10, y = 110},
    {x = 110, y = 110}
)

draw(wall)

