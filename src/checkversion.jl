verexpr = r"(\d+\.?)+"

"""
Given the package directory `pkgpath`, `isprerelease(pkgpath)` returns `true` if there is nothing left after matching $verexpr.
Use this to check whether to registor a version or not.
"""
function isprerelease(pkgpath)
    d = TOML.parsefile(joinpath(pkgpath, "Project.toml"))
    current_ver = VersionNumber(d["version"])
    return isprerelease(current_ver)
end

"""
`isprerelease(ver::VersionNumber)`

# Example
```jldoctest
isprerelease(v"0.99.5")

# output

false
```

```jldoctest
isprerelease(v"0.99.5-DEV")

# output

true
```
"""
function isprerelease(ver::VersionNumber)
    if isempty(ver.prerelease)
        vervalid = false
    else
        vervalid = true
    end
    return vervalid
end
