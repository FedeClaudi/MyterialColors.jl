using Myterial
using Documenter

DocMeta.setdocmeta!(Myterial, :DocTestSetup, :(using Myterial); recursive=true)

makedocs(;
    modules=[Myterial],
    authors="FedeClaudi <federicoclaudi@protonmail.com> and contributors",
    repo="https://github.com/fedeclaudi/Myterial.jl/blob/{commit}{path}#{line}",
    sitename="Myterial.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://fedeclaudi.github.io/Myterial.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/fedeclaudi/Myterial.jl",
    devbranch="main",
)
