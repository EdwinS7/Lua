local Math = {

}; Math.__index = nil; do
    Math.AngleBetweenVector3 = function(origin_cframe, target_vector)
        local directionCFrame = CFrame.new(origin_cframe.Position, origin_cframe.Position + target_vector)
        
        local originOrientation = Vector3.new(origin_cframe:ToOrientation())
        local directionOrientation = Vector3.new(directionCFrame:ToOrientation())
        
        local angleDifference = directionOrientation - originOrientation
        return angleDifference.Magnitude
    end
end

return Math