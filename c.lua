setDefaultTab("BR")

macro(
    100,
    "AREA  FULL",
    function()
        say("death nodo")
    end
)

macro(
    1,
    "SUP ALL",
    function()
        if pr[10] >= now or not canHeal then
            return
        end
        local healHim
        for _, spec in ipairs(getSpectators(posz())) do
            if spec:isPlayer() then
                if spec:getEmblem() == 1 or spec:getShield() >= 3 then
                    if spec ~= player and canBeShoot(spec) then
                        if spec:getSpeed() < 1500 then
                            return useWith(3199, spec)
                        end
                        if
                            spec:getHealthPercent() <= 90 and
                                (not healHim or healHim:getHealthPercent() > spec:getHealthPercent())
                         then
                            healHim = spec
                        end
                    end
                end
            end
        end
        if healHim then
            useWith(3195, healHim)
            useWith(3160, healHim)
        end
    end
)

macro(
    100,
    "CHANGE",
    function()
        local tgt = g_game.getAttackingCreature()
        if not tgt then
            if check1 ~= troca.leg2 then
                moveToSlot(troca.leg2, SlotLeg)
            end
            if check2 ~= troca.amulet2 then
                moveToSlot(troca.amulet2, SlotNeck)
            end
            return
        end
        local targetPos = tgt:getPosition()
        if not targetPos then
            return
        end
        local targetDistance = getDistanceBetween(targetPos, player:getPosition())
        local check1 = getLeg() and getLeg():getId()
        local check2 = getNeck() and getNeck():getId()
        if hppercent() >= 95 and targetDistance < 2 then
            if check1 ~= troca.leg1 then
                moveToSlot(troca.leg1, SlotLeg)
            elseif check2 ~= troca.amulet1 then
                moveToSlot(troca.amulet1, SlotNeck)
            end
        elseif check1 ~= troca.leg2 then
            moveToSlot(troca.leg2, SlotLeg)
        elseif check2 ~= troca.amulet2 then
            moveToSlot(troca.amulet2, SlotNeck)
        end
    end
)

macro(
    100,
    "DOWN",
    function()
        local tgt = g_game.getAttackingCreature()
        if tgt then
            if manapercent() > 75 then
                say("power down")
            else
                say(Fast)
            end
        end
    end
)

macro(
    100,
    "MW ATRAS",
    function()
        if modules.game_console:isChatEnabled() then
            return
        end
        if not modules.corelib.g_keyboard.isKeyPressed("2") then
            return
        end
        pr[1] = now + 200
        local dir = actualDirection()
        local tile
        if dir == 1 then
            tile = g_map.getTile({x = pos().x - 1, y = pos().y, z = pos().z})
        elseif dir == 3 then
            tile = g_map.getTile({x = pos().x + 1, y = pos().y, z = pos().z})
        elseif dir == 2 then
            tile = g_map.getTile({x = pos().x, y = pos().y - 1, z = pos().z})
        elseif dir == 0 then
            tile = g_map.getTile({x = pos().x, y = pos().y + 1, z = pos().z})
        end
        return tile and tile:isWalkable() and useWith(3080, tile:getTopLookThing())
    end
)
