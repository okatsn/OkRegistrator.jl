module OkRegistrator

# Write your package code here.
using TOML
include("checkversion.jl")
export isprerelease

include("folderlist.jl")

using LocalRegistry
include("register.jl")
export tryregisterat
export okciregister

end
