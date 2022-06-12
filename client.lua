local QBCore = exports['qb-core']:GetCoreObject()
local inCasino              = false
local videoWallRenderTarget = nil
local showBigWin            = false
local spinningObject = nil
local spinningCar = nil
--
-- Threads
--

function startCasinoThreads()
    RequestStreamedTextureDict('Prop_Screen_Vinewood')
    while not HasStreamedTextureDictLoaded('Prop_Screen_Vinewood') do
        Wait(100)
    end
    RegisterNamedRendertarget('casinoscreen_01')
    LinkNamedRendertarget(`vw_vwint01_video_overlay`)
    videoWallRenderTarget = GetNamedRendertargetRenderId('casinoscreen_01')
    CreateThread(function()
        local lastUpdatedTvChannel = 0
        while true do
            Wait(0)
            
            if not inCasino then
                ReleaseNamedRendertarget('casinoscreen_01')
                
                videoWallRenderTarget = nil
                showBigWin            = false
                
                break
            end
            if videoWallRenderTarget then
                local currentTime = GetGameTimer()
                if showBigWin then
                    setVideoWallTvChannelWin()
                    lastUpdatedTvChannel = GetGameTimer() - 33666
                    showBigWin           = false
                else
                    if (currentTime - lastUpdatedTvChannel) >= 42666 then
                        setVideoWallTvChannel()
                        lastUpdatedTvChannel = currentTime
                    end
                end
                SetTextRenderId(videoWallRenderTarget)
                SetScriptGfxDrawOrder(4)
                SetScriptGfxDrawBehindPausemenu(true)
                DrawInteractiveSprite('Prop_Screen_Vinewood', 'BG_Wall_Colour_4x4', 0.25, 0.5, 0.5, 1.0, 0.0, 255, 255, 255, 255)
                DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            end
        end
    end)
end


function setVideoWallTvChannel()
    SetTvChannelPlaylist(0, Config.AnimatedWallNormal, true)
    SetTvAudioFrontend(true)
    SetTvVolume(-100.0)
    SetTvChannel(0)
end

function setVideoWallTvChannelWin()
    SetTvChannelPlaylist(0, Config.AnimatedWallWin, true)
    SetTvAudioFrontend(true)
    SetTvVolume(-100.0)
    SetTvChannel(-1)
    SetTvChannel(0)
end

--
-- Events
--

RegisterNetEvent("chCasinoWall:enteredCasino", function()
    inCasino = true
    if Config.SetAnimatedWalls then
        startCasinoThreads()
    end
    if Config.SetShowCarOnDisplay then
        spinMeRightRoundBaby()
    end
end)

RegisterNetEvent("chCasinoWall:exitedCasino", function()
    inCasino = false
end)

RegisterNetEvent('chCasinoWall:bigWin', function()
    if not inCasino then
        return
    end
    showBigWin = true
end)


function enterCasino()
    inCasino = true
    TriggerEvent("chCasinoWall:enteredCasino")
    print("Entered Casino area")
end

function exitCasino()
    TriggerEvent("chCasinoWall:exitedCasino")
    print("Exited Casino area")
    inCasino = false
    Wait(500)
    startCasinoThreads()
end

CreateThread(function()
    local casinoPoly = {}
    casinoPoly[#casinoPoly+1] = PolyZone:Create({
        vector2(1050.0837402344, 33.252941131592),
        vector2(1047.16796875, 28.601387023926),
        vector2(1036.1968994141, 34.407344818115),
        vector2(1033.482421875, 32.862255096436),
        vector2(1029.0247802734, 32.624076843262),
        vector2(1028.7265625, 31.410614013672),
        vector2(1023.3213500977, 34.812046051025),
        vector2(1024.0308837891, 35.920166015625),
        vector2(1023.1451416016, 36.668933868408),
        vector2(1019.9307861328, 33.090438842773),
        vector2(1015.0634155273, 31.122518539429),
        vector2(1011.1212158203, 32.468406677246),
        vector2(1009.1660766602, 33.303230285645),
        vector2(1005.8941040039, 40.158020019531),
        vector2(1001.7928466797, 40.028461456299),
        vector2(1002.1555175781, 43.16100692749),
        vector2(1000.9404296875, 43.0400390625),
        vector2(999.53668212891, 36.055892944336),
        vector2(995.74841308594, 32.294502258301),
        vector2(991.86926269531, 25.583311080933),
        vector2(984.9677734375, 18.012523651123),
        vector2(978.67797851562, 15.911986351013),
        vector2(963.96997070312, 15.563811302185),
        vector2(962.79949951172, 16.319490432739),
        vector2(960.59716796875, 27.42392539978),
        vector2(968.84155273438, 28.056577682495),
        vector2(963.88714599609, 33.738048553467),
        vector2(961.77532958984, 31.825490951538),
        vector2(956.70013427734, 34.998600006104),
        vector2(956.90856933594, 35.948696136475),
        vector2(959.36706542969, 45.600704193115),
        vector2(963.84075927734, 51.349185943604),
        vector2(972.50518798828, 46.344257354736),
        vector2(975.00103759766, 47.120956420898),
        vector2(977.01483154297, 47.016361236572),
        vector2(979.44787597656, 46.999950408936),
        vector2(984.21984863281, 54.131019592285),
        vector2(982.80395507812, 60.549243927002),
        vector2(982.94409179688, 62.542751312256),
        vector2(987.25036621094, 66.15795135498),
        vector2(986.57629394531, 67.642990112305),
        vector2(985.62884521484, 71.840950012207),
        vector2(986.02874755859, 78.615165710449),
        vector2(990.99554443359, 83.21125793457),
        vector2(995.138671875, 83.647193908691),
        vector2(998.90179443359, 82.079475402832),
        vector2(1003.8413085938, 76.087493896484),
        vector2(1012.12, 77.78),
        vector2(1016.18, 75.25),
        vector2(1025.0201416016, 69.797897338867),
        vector2(1035.0809326172, 80.411766052246),
        vector2(1046.9329833984, 77.166969299316),
        vector2(1050.1989746094, 33.48628616333),
    }, {
        name="casinoCombo",
        debugPoly = false,
        minZ = 68,
        maxZ = 75,
    })
    local casinoCombo = ComboZone:Create(casinoPoly, {name = "casinoCombo", debugPoly = false})
    casinoCombo:onPlayerInOut(function(inCasino)
        if inCasino then
            enterCasino()
        else
            exitCasino()
        end
    end)
end)

function spinMeRightRoundBaby()
    CreateThread(function()
        while inCasino do
            if not spinningObject or spinningObject == 0 or not DoesEntityExist(spinningObject) then
                spinningObject = GetClosestObjectOfType(975.68, 40.33, 72.15, 10.0, -1561087446, 0, 0, 0)
                drawCarForWins()
            end
            --vector4(975.68, 40.33, 72.15, 108.54)
            if spinningObject ~= nil and spinningObject ~= 0 then
                local curHeading = GetEntityHeading(spinningObject)
                local curHeadingCar = GetEntityHeading(spinningCar)
                if curHeading >= 360 then
                    curHeading = 0.0
                    curHeadingCar = 0.0
                elseif curHeading ~= curHeadingCar then
                    curHeadingCar = curHeading
                end
                SetEntityHeading(spinningObject, curHeading + 0.075)
                SetEntityHeading(spinningCar, curHeadingCar + 0.075)
            end
            Wait(0)
        end
        spinningObject = nil
    end)
end

function drawCarForWins()
    if DoesEntityExist(spinningCar) then
        DeleteEntity(spinningCar)
    end
    RequestModel(Config.VehicleOnDisplay)
    while not HasModelLoaded(Config.VehicleOnDisplay) do
        Wait(0)
    end
    SetModelAsNoLongerNeeded(Config.VehicleOnDisplay)
    spinningCar = CreateVehicle(Config.VehicleOnDisplay, 975.68, 40.33, 72.15, 108.54, 0.0, 0, 0)
    Wait(0)
    SetVehicleDirtLevel(spinningCar, 0.0)
    SetVehicleOnGroundProperly(spinningCar)
    Wait(0)
    FreezeEntityPosition(spinningCar, 1)
end

function playSomeBackgroundAudioBaby()
    CreateThread(function()
        local function audioBanks()
            while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", true) do
                Wait(0)
            end
            while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", true) do
                Wait(0)
            end
            while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", true) do
                Wait(0)
            end
            while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", true) do
                Wait(0)
            end
        end
        while inCasino do
            audioBanks()
            if not IsStreamPlaying() and LoadStream("casino_walla", "DLC_VW_Casino_Interior_Sounds") then
                PlayStreamFromPosition(990.32, 42.73, 71.84)
            end
            if IsStreamPlaying() and not IsAudioSceneActive("DLC_VW_Casino_General") then
                StartAudioScene("DLC_VW_Casino_General")
            end
            Wait(1000)
        end
        if IsStreamPlaying() then
            StopStream()
        end
        if IsAudioSceneActive("DLC_VW_Casino_General") then
            StopAudioScene("DLC_VW_Casino_General")
        end
    end)
end
