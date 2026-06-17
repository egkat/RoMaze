local Studio = settings().Studio

return function(key: string)
    return Studio[key]
end
