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

function node:CompareTo(otherNode)
    return (node.x == otherNode.x and node.y == otherNode.y)
end

function node:SharesY(otherNode)
    return (node.y == otherNode.y)
end

function node:SharesX(otherNode)
    return (node.x == otherNode.x)
end

return node