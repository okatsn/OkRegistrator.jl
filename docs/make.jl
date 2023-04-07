using OkRegistrator
using Documenter

DocMeta.setdocmeta!(OkRegistrator, :DocTestSetup, :(using OkRegistrator); recursive=true)

makedocs(;
    modules=[OkRegistrator],
    authors="okatsn <okatsn@gmail.com> and contributors",
    repo="https://github.com/okatsn/OkRegistrator.jl/blob/{commit}{path}#{line}",
    sitename="OkRegistrator.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://okatsn.github.io/OkRegistrator.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/okatsn/OkRegistrator.jl",
    devbranch="main",
)
