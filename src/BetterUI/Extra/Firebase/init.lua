--[=[
    @class DefaultFirebaseService
    FirebaseService **but** without setup.
]=]

local httpService = game:GetService"HttpService"
local dss = game:GetService"DataStoreService"
local RunService = game:GetService("RunService")

--[=[
    @function setup
    @within DefaultFirebaseService
    @return FirebaseService
    @param options FirebaseOptions
]=]

--- @interface FirebaseOptions
--- @within DefaultFirebaseService
--- .databaseUrl string -- The URL of the datastore
--- .authToken string -- The authentication token of the firebase
--- 
--- The options for firebase
--- :::warning
--- Any of the properties being invalid will break the firebase service.
--- :::

return {
    ["setup"] = function(options)
        --[=[
            @class FirebaseService
            Google Firebase - Roblox DataStore
        ]=]
        --[=[
            @prop Locked boolean
            @within FirebaseService
            Defines whether the database should not receive any new entries.
        ]=]
        --[=[
            @prop DatabaseURL string
            @within FirebaseService
            Defines the URL of the base database.
        ]=]
        --[=[
            @prop AuthToken string
            @within FirebaseService
            Defines the authToken of the base database.
        ]=]
        local FirebaseService = {
            ["Locked"] = false;
            ["DatabaseURL"] = options.databaseUrl;
            ["AuthToken"] = options.authToken;
        }

        --[=[
         @within FirebaseService
         @method Lock
         Locks or unlocks the firebase.
         @param locked boolean?
         @return boolean
]=]--
        function FirebaseService:Lock(locked: boolean?)
            locked = locked or ( not locked )
            FirebaseService.Locked = locked
            return locked
        end

        --[=[
            @within FirebaseService
            @method getDB
            Finds a datastore from URL
            @param name string -- Name of the database
            @param database string? -- URL of the database (Optional)
            @return SnwDB
        ]=]
        function FirebaseService:getDB(name, database)
            database = database or FirebaseService.DatabaseURL
            local datastore = dss:GetDataStore(name)
            local dbn = database .. httpService:UrlEncode(name)
            local auth = ".json?auth=" .. FirebaseService.AuthToken

            --[=[
                @class SnwDB
                Database (Google Firebase) Extension By SnwDevelopment
            ]=]

            --[=[
                @function GetDB
                @within SnwDB
                Gets the GlobalDatabase with 0 keys
            ]=]

            --[=[
                @function get
                @within SnwDB
                Get a directory from database
            ]=]

            --[=[
                @function set
                @within SnwDB
                Sets the value of the key. This action overwrites any existing data stored in the provided key.
                @param dir string -- Directory of database
                @param value string -- The value can be any basic types. Using `HttpService:JSONEncode` is recommended before you sending this function call.
                :::info
                If database is locked, you can not overwrite any variable.
                ::: 
            ]=]

            --[=[
                @function delete
                @within SnwDB
                Deletes the given key from data store and returns the value associated with that key.
                @param dir string -- Dierctory of the value that you are looking for.
            ]=]
            local SnwDB = {
                ["GetDB"] = function()
                    return datastore
                end
            }

            SnwDB["get"] = function(key)
                local data = nil
                local t = tick()
                local tries = 0; repeat until pcall(function() tries = tries +1;
                    data = httpService:GetAsync(dbn .. httpService:UrlEncode(key and "/"..key or "") .. FirebaseService.AuthToken, true);
                end) or tries > 2
                if type(data) == "string" then
                    if data:sub(1,1) == '"' then
                        return data:sub(2, data:len()-1);
                    elseif data:len() <= 0 then
                        return nil;
                    end
                end
                return tonumber(data) or data ~= "null" and data or nil
            end

            SnwDB["set"] = function(dir, value)
                if FirebaseService.Locked == true then return error("[SnwDB.Firebase]→ TypeError: Firebase is locked. Use `{FirebaseService}:Lock(false)` and retry again.") end
                if RunService:IsServer() == false then
                    return error("[SnwDB.Firebase]→ FatalError: Attempted to index \".set\" in client-sided scripts.")
                end
                if value == "[]" then return T end
                local header = {
                    ["X-HTTP-Method-Override"] = "PUT"
                }
                local reply = ""
                if type(value) == "string" and value:len() >= 1 and value:sub(1, 1) ~= "{" and value:sub(1, 1) ~= "[" then
                    value = '"' .. value .. '"'
                end
                local d = pcall(function()
                    reply = httpService:PostAsync(dbn .. httpService:UrlEncode(dir and "/" .. dir or "") .. auth, value, Enum.HttpContentType.ApplicationUrlEncoded, false, header)
                end)
                if not d[1] then
                    error(string.format("[SnwDB.Firebase]→ DataSetError: Failed to set query %s with data %s as %s", dir, value, d[2]))
                    pcall(function()
                        reply = httpService:JSONDecode(reply or "[]")
                    end)
                end
            end

            SnwDB["delete"] = function(dir)
                if FirebaseService.Locked == true then return error("[SnwDB.Firebase]→ TypeError: Firebase is locked. Use `{FirebaseService}:Lock(false)` and retry again.") end
                SnwDB.set(dir, "");
            end

            --[=[
                @function add
                @within SnwDB
                Increases the value of a provided key and returns the increased value.
                :::warning Type Checking
                If the key value's type is not number, an error will be thrown.
                :::
                @param dir string -- Key of the value that you are looking for.
                @param delta number? -- The increasement value
            ]=]

            SnwDB["add"] = function(dir, delta)
                delta = delta or 1
                if type(delta) ~= "number" then return error(string.format("[SnwDB.Firebase]→ TypeError: Argument of type '%s' is not assignable to parameter of type '%s'", type(delta), "number")) end
                local d = SnwDB.get(dir) or 0
                if d and type(d) == "number" then
                    d = d + delta
                    SnwDB.set(dir, d);
                else
                    error(string.format("[SnwDB.Firebase]→ TypeError: Argument of type '%s' is not assignable to parameter of type '%s'", "number", type(d)))
                end
            end

            return SnwDB
        end

        return FirebaseService
    end
}