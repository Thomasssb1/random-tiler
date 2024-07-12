local tile = {}

function tile.new(quads)
    local self = setmetatable({}, {__index = tile})
    self.quads = quads
    self.colour = {math.random(), math.random(), math.random()}
    return self
end

function tile:Draw(cr)
    cr:new_sub_path()
    cr:set_source_rgb(table.unpack(self.colour))
    for _, quad in ipairs(self.quads) do
        quad:Draw(cr)
    end
    cr:fill()
end

return tile