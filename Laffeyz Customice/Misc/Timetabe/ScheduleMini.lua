-- ScheduleMini.lua
-- Dung !SetVariable để set dynamic variables
-- .ini sẽ đọc bằng #Today1#, #Tmrw1#, etc.

function Initialize()
end

function Update()
    -- os.date("%w"): 0=Sun, 1=Mon, ..., 6=Sat
    local day = tonumber(os.date("%w"))
    
    local dayMap = {
        [0] = 'Sun',
        [1] = 'Mon',
        [2] = 'Tue',
        [3] = 'Wed',
        [4] = 'Thu',
        [5] = 'Fri',
        [6] = 'Sat'
    }
    
    local nameMap = {
        [0] = 'SUN',
        [1] = 'MON',
        [2] = 'TUE',
        [3] = 'WED',
        [4] = 'THU',
        [5] = 'FRI',
        [6] = 'SAT'
    }
    
    local todayPrefix = dayMap[day]
    local tomorrowPrefix = dayMap[(day + 1) % 7]
    
    local timeLabels = { '07:15', '09:25', '12:00', '14:10' }
    
    -- Set header variables
    SKIN:Bang('!SetVariable', 'HeaderToday', '[TODAY] ' .. nameMap[day] .. ' ' .. os.date("%d/%m"))
    SKIN:Bang('!SetVariable', 'HeaderTmrw', '[TMRW] ' .. nameMap[(day + 1) % 7])
    
    -- Set TODAY slot variables
    for i = 1, 4 do
        local val = SKIN:GetVariable(todayPrefix .. i, '')
        if val == '' then val = '-' end
        SKIN:Bang('!SetVariable', 'Today' .. i, timeLabels[i] .. '  ' .. val)
    end
    
    -- Set TOMORROW slot variables
    for i = 1, 4 do
        local val = SKIN:GetVariable(tomorrowPrefix .. i, '')
        if val == '' then val = '-' end
        SKIN:Bang('!SetVariable', 'Tmrw' .. i, timeLabels[i] .. '  ' .. val)
    end
    
    return ''
end