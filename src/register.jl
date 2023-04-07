function tryregisterat(pkgpath, regpath)
    iserrored = false
    try
        register(
            pkgpath,
            registry=regpath,
            push=true # optional
        )
    catch e
        iserrored = true
        pkgname, pkgdir = map(f-> f(pkgpath), (basename, dirname))
        @warn "($(pkgname)) Error occurred registrating $pkgpath to $regpath."
        @warn "Skipped (Error message: $e)"
    end
    return iserrored
end

"""
`exprnotreg(regrepo)` returns expression not matching `regrepo`.

# Example
```jldoctest foobarrr
expr = OkRegistrator.exprnotreg("OkRegistry")
occursin(expr, ".julia/dev/OkRegistry")

# output

false
```

```jldoctest foobarrr
occursin(expr, ".julia/dev/NotOkRegistry")

# output

false
```

```jldoctest foobarrr
occursin(expr, ".julia/dev/NotOkAtRegistryAll")

# output

true
```
"""
exprnotreg(regrepo) = Regex("^((?!$regrepo).)*\$")

function okciregister(okregpath)
    regrepo = basename(okregpath)
    dirmain(args...) = joinpath(dirname(okregpath), args...) # The parent of pwd (which should be .../OkRegistry/)
    localpkgpaths = folderlist(exprnotreg(regrepo), dirmain()) # all folders under dirmain that is not "OkRegistry".
    iserrored = false
    for pkgpath in localpkgpaths
        iserrored = tryregisterat(pkgpath, okregpath)
    end

    if iserrored
        error("At least one error occurred in the session.")
    end
end
