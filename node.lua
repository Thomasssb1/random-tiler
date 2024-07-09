local node = {}

function node.new(x, y)
    local self = setmetatable({}, {__index = node})
    self.x = x
    self.y = y
    return self
end

function node:distanceBetween(otherNode)
    return math.sqrt((otherNode.x - self.x)^2 + (otherNode.y - self.y)^2)
end

return node