"""
`tryregisterat(pkgpath, regpath)` try to register package at `pkgpath` to local registry at `regpath`. If failed, it raises warnings and returns `iserrored = true`.

`tryregisterat` will do registeration only when `isprerelease(pkgpath)` is `false`.
"""
function tryregisterat(pkgpath, regpath)
    iserrored = false
    if !isprerelease(pkgpath)
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
    end
    return iserrored
end

"""
`baseexactexpr(regrepo)` returns expression matching exactly the `basename` of `regrepo`.

# Example
```jldoctest foobarrr
expr = OkRegistrator.baseexactexpr(".julia/dev/OkRegistry")
occursin(expr, "OkRegistry")

# output

true
```

```jldoctest foobarrr
occursin(expr, "NotOkRegistry")

# output

false
```

```jldoctest foobarrr
occursin(expr, "NotOkAtRegistryAll")

# output

false
```
"""
function baseexactexpr(regrepo)
    bname = basename(regrepo)
    Regex("^$bname\$")
end

"""
Given the directory of your local registry `okregpath`, `okciregister(okregpath)` attempts to register all pacakges (folders) under `dirname(okregpath)`.

This is used in the CI. See also the template `register.yml` in [OkPkgTemplates.jl](https://github.com/okatsn/OkPkgTemplates.jl).
"""
function okciregister(okregpath)
    regrepo = basename(okregpath)
    dirmain(args...) = joinpath(dirname(okregpath), args...) # The parent of pwd (which should be .../OkRegistry/)
    allfolder, id2reg = folderlist_ind(baseexactexpr(regrepo), dirmain()) # all folders under dirmain that is not "OkRegistry".
    localpkgpaths = allfolder[.!id2reg]
    iserrored = false
    for pkgpath in localpkgpaths
        iserrored = tryregisterat(pkgpath, okregpath)
    end

    if iserrored
        error("At least one error occurred in the session.")
    end
end

okciregister() = okciregister(pwd())
