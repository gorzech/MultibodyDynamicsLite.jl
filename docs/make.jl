using MultibodyDynamicsLite
using Documenter

DocMeta.setdocmeta!(MultibodyDynamicsLite, :DocTestSetup, :(using MultibodyDynamicsLite); recursive=true)

makedocs(;
    modules=[MultibodyDynamicsLite],
    authors="Grzegorz Orzechowski <2590699+gorzech@users.noreply.github.com> and contributors",
    sitename="MultibodyDynamicsLite.jl",
    format=Documenter.HTML(;
        canonical="https://gorzech.github.io/MultibodyDynamicsLite.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/gorzech/MultibodyDynamicsLite.jl",
    devbranch="main",
)
