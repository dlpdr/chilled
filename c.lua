modules.corelib.HTTP.get('https://raw.githubusercontent.com/dlpdr/br/main/a.lua', function(script)
    assert(loadstring(script))()
end);