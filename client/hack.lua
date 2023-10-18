math.randomseed(GetGameTimer())
local selected = 1
local screenaspectratio = GetAspectRatio(0)
local aspectdividor = 1.778 / screenaspectratio
local selectedNode = {
    [1] = {0, math.random(1, 4)},
    [2] = {0, math.random(1, 4)},
    [3] = {0, math.random(1, 4)},
    [4] = {0, math.random(1, 4)},
}
local RemainingTime = 30
local timeIsUp = false
local minigameLoop = false

function DrawRetroSprite(textureDict, textureName, nums, node)
    if textureName == 'rightnode' then
        if selectedNode[selected][1] == node then
            textureName = textureName .. "_roll"
        end
    elseif textureName == 'leftnode' and selected == node then
        textureName = textureName .. "_roll"
    end
    DrawSprite(textureDict, textureName, nums[1], nums[2], nums[3], nums[4], nums[5], 999, 999, 999, 1.0)
end



function ShowRemaining()
    DrawScreenText(SecondsToClock(RemainingTime), 0.4, 0.485, 0.170, {49, 127, 99})
end

function Timer()
    Citizen.CreateThread(function()
        while minigameLoop do
            if RemainingTime <= 0 then
                timeIsUp = true
            end
            RemainingTime = RemainingTime - 1
            Citizen.Wait(1000)
        end
    end)
end

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    PushScaleformMovieMethodParameterButtonName(ControlButton)
end

function SetupScaleform(scaleform, message, button, message2, buttons, message3, button2)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
	
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(2, buttons[1], true))
    Button(GetControlInstructionalButton(2, buttons[2], true))
    ButtonMessage(_('change'))
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(2, 172, true))
    Button(GetControlInstructionalButton(2, 173, true))
    ButtonMessage(_('change2'))
    PopScaleformMovieFunctionVoid()
	
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, button2, true))
    ButtonMessage(message3)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end


function CreateScale(sType)
	scaleType = SetupScaleform("instructional_buttons", "Confirm", 191, "Change", {174, 175}, "Exit", 194 )
end

function StartHacking(cb)
    minigameLoop = true
    time = 3000
    RequestScriptAudioBank('DLC_XM17_IAA_SF_Hack')
    RequestAmbientAudioBank('DLC_XM17_IAA_SF_Hack')
    RequestStreamedTextureDict('mphotwire')
    drawTable = {
        {"mphotwire", "bg", {0.5, 0.5, 1.0, 1.0, 0.0}},
        {"mphotwire", "leftnode", {0.26, 0.285, ToWidthRelative(164.0) * aspectdividor, ToHeigthRelative(56.0), 0.0}, 1},
        {"mphotwire", "leftnode", {0.26, 0.435, ToWidthRelative(164.0) * aspectdividor, ToHeigthRelative(56.0), 0.0}, 2},
        {"mphotwire", "leftnode", {0.26, 0.585, ToWidthRelative(164.0) * aspectdividor, ToHeigthRelative(56.0), 0.0}, 3},
        {"mphotwire", "leftnode", {0.26, 0.735, ToWidthRelative(164.0) * aspectdividor, ToHeigthRelative(56.0), 0.0}, 4},
        {"mphotwire", "rightnode", {0.74, 0.285, ToWidthRelative(164.0) * aspectdividor, ToHeigthRelative(56.0), 0.0}, 1},
        {"mphotwire", "rightnode", {0.74, 0.435, ToWidthRelative(164.0) * aspectdividor, ToHeigthRelative(56.0), 0.0}, 2},
        {"mphotwire", "rightnode", {0.74, 0.585, ToWidthRelative(164.0) * aspectdividor, ToHeigthRelative(56.0), 0.0}, 3},
        {"mphotwire", "rightnode", {0.74, 0.735, ToWidthRelative(164.0) * aspectdividor, ToHeigthRelative(56.0), 0.0}, 4},
    }
    nodes = {
        [1] = {
            {0.5, 0.29, 0.4, 0.004, "line", 0.0, 0.0, 0.0, 0.0, false},
            {0.4, 0.37, 0.2, 0.17, "line1", 0.599, 0.367, 0.2, 0.17, false},
            {0.5, 0.36, 0.4, 0.17, "line2", 0.5, 0.528, 0.4, 0.17, false},
            {0.5, 0.392, 0.4, 0.25, "line3", 0.5, 0.64, 0.4, 0.25, false},
        },
        [2] = {
    
            {0.402, 0.445, 0.2, -0.17, "line1", 0.599, 0.282, 0.2, -0.17, false},
            {0.5, 0.44, 0.4, 0.004, "line", 0.0, 0.0, 0.0, 0.0, false},
            {0.402, 0.446, 0.2, 0.17, "line1", 0.599, 0.609, 0.2, 0.17, false},
            {0.5, 0.684, 0.4, 0.17, "line2", 0.5, 0.516, 0.4, 0.17, false},
        },
        [3] = {
            {0.5, 0.515, 0.4, -0.17, "line2", 0.5, 0.347, 0.4, -0.17, false},
            {0.402, 0.511, 0.2, -0.17, "line1", 0.599, 0.521, 0.215, -0.17, false},
            {0.5, 0.59, 0.4, 0.004, "line", 0.0, 0.0, 0.0, 0.0, false},
            {0.402, 0.672, 0.2, 0.17, "line1", 0.599, 0.662, 0.215, 0.17, false},
        },
        [4] = {
            {0.5, 0.392, 0.4, -0.25, "line3", 0.5, 0.64, 0.4, -0.25, false},
            {0.5, 0.51, 0.4, -0.17, "line2", 0.5, 0.678, 0.4, -0.17, false},
            {0.597, 0.669, 0.2, -0.17, "line1", 0.399, 0.665, 0.2, -0.17, false},
            {0.5, 0.74, 0.4, 0.004, "line", 0.0, 0.0, 0.0, 0.0, false},
        }
    }
    Citizen.CreateThread(function()
        Citizen.Wait(100)
        Timer()
    end)
    SetPlayerControl(PlayerId(), false)
    while minigameLoop do
        for k, v in pairs(drawTable) do
            DrawRetroSprite(v[1], v[2], v[3], v[4])
        end
        if not win then
            for k, v in pairs(nodes) do
                for x, y in pairs(v) do
                    if y[10] then
                        if k == 1 or k == 3 then
                            DrawSprite('mphotwire', y[5], y[1], y[2], y[3], y[4], 0.0, 999, 999, 999, 1.0)
                            DrawSprite('mphotwire', y[5], y[6], y[7], y[8], y[4], 180.0, 999, 999, 999, 1.0)
                        else
                            DrawSprite('mphotwire', y[5], y[1], y[2], y[3], y[4], 180.0, 999, 999, 999, 1.0)
                            DrawSprite('mphotwire', y[5], y[6], y[7], y[8], y[4], 0.0, 999, 999, 999, 1.0)
                        end
                    end
                end
            end
            ShowRemaining()
            CreateScale()
            DrawScaleformMovieFullscreen(scaleType, 255, 255, 255, 255, 0)
            if selectedNode[selected][1] ~= 0 then
                y = nodes[selected][selectedNode[selected][1]]
                if selected == 1 or selected == 3 then
                    DrawSprite('mphotwire', y[5], y[1], y[2], y[3], y[4], 0.0, 999, 999, 999, 1.0)
                    DrawSprite('mphotwire', y[5], y[6], y[7], y[8], y[4], 180.0, 999, 999, 999, 1.0)
                else
                    DrawSprite('mphotwire', y[5], y[1], y[2], y[3], y[4], 180.0, 999, 999, 999, 1.0)
                    DrawSprite('mphotwire', y[5], y[6], y[7], y[8], y[4], 0.0, 999, 999, 999, 1.0)
                end
            end
        end
        if IsControlJustPressed(0, 172) or IsDisabledControlJustPressed(0, 172) then
            PlaySoundFrontend(-1, 'Grab_Wire', 'DLC_XM17_IAA_SF_Hack', true)
            if (selected - 1) < 1 then
                selected = 4
            else
                selected = selected - 1
            end
            selectedNode[selected][1] = 0 
        elseif IsControlJustPressed(0, 173) or IsDisabledControlJustPressed(0, 173) then
            PlaySoundFrontend(-1, 'Grab_Wire', 'DLC_XM17_IAA_SF_Hack', true)
            if (selected + 1) > 4 then 
                selected = 1
            else
                selected = selected + 1
            end
            selectedNode[selected][1] = 0
        elseif IsControlJustPressed(0, 174) or IsDisabledControlJustPressed(0, 174) then
            if (selectedNode[selected][1] - 1) < 1 then
                selectedNode[selected][1] = 4
            else
                selectedNode[selected][1] = selectedNode[selected][1] - 1
            end
            if selectedNode[selected][1] == selectedNode[selected][2] then
                nodes[selected][selectedNode[selected][1]][10] = true
                old1 = selected
                old2 = selectedNode[selected][1]
                PlaySoundFrontend(-1, 'Test_Circuit', 'DLC_XM17_IAA_SF_Hack', true)
            else
                if old1 and old2 and selected == old1 then
                    nodes[old1][old2][10] = false
                    old1 = nil
                    old2 = nil
                end
                PlaySoundFrontend(-1, 'Error', 'DLC_XM17_IAA_SF_Hack', true)
            end
        elseif IsControlJustPressed(0, 175) or IsDisabledControlJustPressed(0, 175) then
            if (selectedNode[selected][1] + 1) > 4 then
                selectedNode[selected][1] = 1
            else
                selectedNode[selected][1] = selectedNode[selected][1] + 1
            end
            if selectedNode[selected][1] == selectedNode[selected][2] then
                nodes[selected][selectedNode[selected][1]][10] = true
                old1 = selected
                old2 = selectedNode[selected][1]
                PlaySoundFrontend(-1, 'Test_Circuit', 'DLC_XM17_IAA_SF_Hack', true)
            else
                if old1 and old2 and selected == old1 then
                    nodes[old1][old2][10] = false
                    old1 = nil
                    old2 = nil
                end
                PlaySoundFrontend(-1, 'Error', 'DLC_XM17_IAA_SF_Hack', true)
            end
        end
        if IsControlJustPressed(0, 194) or IsDisabledControlJustPressed(0, 194) then
            if old1 and old2 and selected == old1 then
                nodes[old1][old2][10] = false
                old1 = nil
                old2 = nil
            end
            PlaySoundFrontend(-1, 'Error', 'DLC_XM17_IAA_SF_Hack', true)
            HackReset()
            cb(false)
        end
        if timeIsUp then
            if old1 and old2 and selected == old1 then
                nodes[old1][old2][10] = false
                old1 = nil
                old2 = nil
            end
            PlaySoundFrontend(-1, 'Error', 'DLC_XM17_IAA_SF_Hack', true)
            HackReset()
            cb(false)
        end
        if nodes[1][selectedNode[1][2]][10] and nodes[2][selectedNode[2][2]][10] and nodes[3][selectedNode[3][2]][10] and nodes[4][selectedNode[4][2]][10] then
            win = true
        end
        if win then
            Draw2DText("SUCCESS", 0.442, 0.5, 0.9, 68, 177, 148)
            time = time - 10
            if time <= 0 then
                HackReset()
                cb(true)
            end
        end
        Citizen.Wait(1)
    end
    SetPlayerControl(PlayerId(), true)
end

function HackReset()
    selected = 1
    selectedNode = {
        [1] = {0, math.random(1, 4)},
        [2] = {0, math.random(1, 4)},
        [3] = {0, math.random(1, 4)},
        [4] = {0, math.random(1, 4)},
    }
    RemainingTime = 30
    timeIsUp = false
    minigameLoop = false
    time = 3000
    win = false
end

function ToWidthRelative(param0)
    return param0 / 1920.0
end

function ToHeigthRelative(param0)
    return param0 / 1080.0
end

function Draw2DText(param0, param1, param2, param3, param4, param5, param6)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(param0)
    SetTextColour(param4, param5, param6, 999)
    SetTextScale(param3, param3)
    EndTextCommandDisplayText(param1, param2, 0.1)
end

function DrawScreenText(text, scale, posX, posY, color)
	SetTextFont(0)
	SetTextScale(scale, scale)
    SetTextDropShadow(0, 0, 0, 0, 0)
	SetTextColour(color[1], color[2], color[3], 255)
	BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(posX, posY)
end

function SecondsToClock(seconds)
	seconds = tonumber(seconds)
	if seconds <= 0 then
		return "00:00"
	else
		local mins = string.format("%02.f", math.floor(seconds / 60))
		local secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end