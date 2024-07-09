local node = require "node"
local quad = {}

function quad.new(point1, point2, point3, point4)
    local self = setmetatable({}, {__index = quad})
    self.point1 = node.new(point1.x, point1.y)
    self.point2 = node.new(point2.x, point2.y)
    self.point3 = node.new(point3.x, point3.y)
    self.point4 = node.new(point4.x, point4.y)
    local polygons = {}
    return self
end

function quad:TileSquares(cr, height, width, tileSize)
    local max, min = self:GetMinMax()
    local total = {}
    for y = min.y, max.y - height, height do
        for x = min.x, max.x - width, width do
            local newQuad = quad.new(
                {x = x, y = y},
                {x = x + width, y = y},
                {x = x, y = y + height},
                {x = x + width, y = y + height}
            )
            newQuad:Draw(cr)
            table.insert(total, newQuad)
        end
    end
end

function quad:GetMinMax()
    local maxX, minX = -math.huge, math.huge
    local maxY, minY = -math.huge, math.huge
    local function checkForMinMax(point)
        if point.x > maxX then
            maxX = point.x
        elseif point.x < minX then
            minX = point.x
        end
        if point.y > maxY then
            maxY = point.y
        elseif point.y < minY then
            minY = point.y
        end
    end

    checkForMinMax(self.point1)
    checkForMinMax(self.point2)
    checkForMinMax(self.point3)
    checkForMinMax(self.point4)
    return {x = maxX, y = maxY}, {x = minX, y = minY}
end

function quad:Draw(cr)
    local min, max = self:GetMinMax()
    local width = max.x - min.x
    local height = max.y - min.y
    cr:set_source_rgb(1, 0, 0)
    cr:rectangle(min.x, min.y, width, height)
    cr:stroke()
end

return quad