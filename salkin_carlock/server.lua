local ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('salkin_carlock:isVehicleOwner', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(false) end

    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = identifier,
        ['@plate'] = plate
    }, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)