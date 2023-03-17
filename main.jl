include("Parametrizations/Parsec.jl")
using Plots, Xfoil

function main()
    exampleAirfoil = AirfoilPARSEC(0.02, 0.005, 0.43, 0.12, 0.23, -0.018, -0.8, 0.4, -0.001, 0, -5*π/180, 25*π/180)
    points = generateCoordinates(exampleAirfoil, 35)
    

    # read airfoil coordinates 
    xp, yp = Float64[], Float64[]
    for point in points
        push!(xp,point[1])
        push!(yp,point[2])
    end

    # load airfoil coordinates into XFOIL
    Xfoil.set_coordinates(xp,yp)
    x, y = Xfoil.pane()

    # plot the airfoil geometry
    scatter(x, y, label="airfoil PARSEC", show=true)
    xlims!((0.0,1.0))
    ylims!((-0.5,0.5))


    # scatter(points, xlabel="x", ylabel="y", label="airfoil PARSEC")
    # xlims!((0.0,1.0))
    # ylims!((-0.5,0.5))
end

main()