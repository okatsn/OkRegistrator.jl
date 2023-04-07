module OkRegistrator

# Write your package code here.
using TOML
include("checkversion.jl")
export isprerelease

using LocalRegistry
include("register.jl")
export tryregisterat

end
