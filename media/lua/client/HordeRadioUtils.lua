if isServer() then return; end

local RadioUtils = {}

function RadioUtils:GetRadioIntensity(player, radio)
    local itemModData = radio:getModData();
    if itemModData.intensity == nil then
        itemModData.intensity = 10;
    end

    return itemModData.intensity;
end

function RadioUtils:SetRadioIntensity(player, radio, intensity)
    local itemModData = radio:getModData();
    itemModData.intensity = intensity;
end

return RadioUtils;