local node = require "node"
local tile = require "tile"
local quad = {}

function quad.new(point1, point2, point3, point4)
    local self = setmetatable({}, {__index = quad})
    self.point1 = node.new(point1.x, point1.y)
    self.point2 = node.new(point2.x, point2.y)
    self.point3 = node.new(point3.x, point3.y)
    self.point4 = node.new(point4.x, point4.y)
    return self
end

function quad:TileSquares(height, width, tileSize)
    local max, min = self:GetMinMax()
    local total = {}
    local currentTile = {}
    local xInterval, yInterval = math.floor((max.x - min.x) / width), math.floor((max.y - min.y)/ height)
    local reverse = false
    for y = min.y, (yInterval * height) - yInterval + min.y, yInterval do

        local start = reverse and (xInterval * width) + min.x - xInterval or min.x
        local finish = reverse and min.x or (xInterval * width) - xInterval + min.x

        for x = start, finish, reverse and -xInterval or xInterval do

            local newQuad = quad.new(
                    {x = x, y = y},
                    {x = x + xInterval, y = y},
                    {x = x, y = y + yInterval},
                    {x = x + xInterval, y = y + yInterval}
                )
            
            table.insert(currentTile, newQuad)
            if (#currentTile == tileSize) then
                table.insert(total, tile.new(currentTile))
                currentTile = {}
            end
        end
        reverse = not reverse
    end
    table.insert(total, tile.new(currentTile))
    return total
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
    cr:rectangle(min.x, min.y, width, height)
end

return quad