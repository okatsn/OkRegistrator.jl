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
