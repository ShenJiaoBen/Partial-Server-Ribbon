local signal = {}
    signal.__index = signal

    function signal.new()
        local self = setmetatable({}, signal)
        self.connections = {}
        self._is_destroyed = false
        return self
    end

    function signal:Connect(func)
        if self._is_destroyed then return nil end
        if type(func) ~= "function" then warn("u need a function", 2) end

        local connection = {}
        local key = connection

        self.connections[key] = func

        function connection:Disconnect()
            if self._signal then
                self._signal.connections[key] = nil
                self._signal = nil
            end
        end

        connection._signal = self
        return connection
    end

    function signal:Fire(...)
        if self._is_destroyed then return end
        for _, func in pairs(self.connections) do
            task.spawn(func, ...)
        end
    end

    function signal:Destroy()
        self._is_destroyed = true
        for key, _ in pairs(self.connections) do
            self.connections[key] = nil
        end
        self.connections = nil
        setmetatable(self, nil)
    end

return signal
