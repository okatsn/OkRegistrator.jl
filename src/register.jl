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

regrepoexpr(regrepo) = Regex("^((?!$regrepo).)*\$")

function okciregister(okregpath; regrepo = "OkRegistry")
    dirmain(args...) = joinpath(dirname(okregpath), args...) # The parent of pwd (which should be .../OkRegistry/)
    dir_myregistry = dirmain(regrepo)
    localpkgpaths = folderlist(regrepoexpr(regrepo), dirmain()) # all folders under dirmain that is not "OkRegistry".
end
