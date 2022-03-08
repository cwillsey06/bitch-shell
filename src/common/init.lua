return {
    __newindex = function(_, k)
        return 'src/common/'.. k:lower()
    end
}