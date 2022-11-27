if isServer() then return; end

local RadioUtils = require "HordeRadioUtils"

local function activateRadio(p, radio)
    print('Context menu activated successfully')
    getSoundManager():PlaySound("activate", false, 5);
    local x = getPlayer():getX()
    local y = getPlayer():getY()
    local z = getPlayer():getZ()

    local intensity = RadioUtils:GetRadioIntensity(p, radio)

    local worldSoundManager = getWorldSoundManager()
    worldSoundManager:addSound(nil, x, y, z, intensity, intensity)

    local sayString = "Activated with intensity set to " .. intensity .. "...here we go!"
    p:Say(sayString)
    -- radio:Say(sayString)
end

local function AddHordeRadioContextMenu(player, context, items)
    local item

    if #items > 1 then return; end

    for i = 1, #items do
        if not instanceof(items[i], "InventoryItem") then
            item = items[i].items[1]
        else
            item = items[i]
        end

        if item:getType() ~= "HordeRadio" then
            return;
        end
    end

    local playerObj = getPlayer();

    context:addOption(getText("IGUI_hordeRadio_activate"), playerObj, activateRadio, item);

    local parentMenu = context:addOption(getText("IGUI_hordeRadio_set_intensity"));
    local childMenu = ISContextMenu:getNew(context);
    context:addSubMenu(parentMenu, childMenu);
    local currentIntensityString = getText("IGUI_hordeRadio_current_intensity") .. tostring(RadioUtils:GetRadioIntensity(playerObj, item))

    childMenu:addOption(currentIntensityString);

    childMenu:addOption(getText("IGUI_hordeRadio_intensity_1"), playerObj, function() RadioUtils:SetRadioIntensity(playerObj, item, 100) end, item);
    childMenu:addOption(getText("IGUI_hordeRadio_intensity_2"), playerObj, function() RadioUtils:SetRadioIntensity(playerObj, item, 200) end, item);
    childMenu:addOption(getText("IGUI_hordeRadio_intensity_3"), playerObj, function() RadioUtils:SetRadioIntensity(playerObj, item, 300) end, item);
    childMenu:addOption(getText("IGUI_hordeRadio_intensity_4"), playerObj, function() RadioUtils:SetRadioIntensity(playerObj, item, 5000) end, item);
    childMenu:addOption(getText("IGUI_hordeRadio_intensity_5"), playerObj, function() RadioUtils:SetRadioIntensity(playerObj, item, 1000) end, item);
    childMenu:addOption(getText("IGUI_hordeRadio_intensity_6"), playerObj, function() RadioUtils:SetRadioIntensity(playerObj, item, 2000) end, item);
    childMenu:addOption(getText("IGUI_hordeRadio_intensity_7"), playerObj, function() RadioUtils:SetRadioIntensity(playerObj, item, 5000) end, item);
    childMenu:addOption(getText("IGUI_hordeRadio_intensity_8"), playerObj, function() RadioUtils:SetRadioIntensity(playerObj, item, 10000) end, item);
    childMenu:addOption(getText("IGUI_hordeRadio_intensity_9"), playerObj, function() RadioUtils:SetRadioIntensity(playerObj, item, 100000) end, item);
end

local firstUpdate = true;

local function OnPlayerUpdate(player)
    if firstUpdate and player == getPlayer() then
        firstUpdate = false;
        Events.OnFillInventoryObjectContextMenu.Add(AddHordeRadioContextMenu);
    end
end

Events.OnPlayerUpdate.Add(OnPlayerUpdate)