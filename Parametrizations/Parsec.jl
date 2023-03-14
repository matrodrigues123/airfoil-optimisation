struct AirfoilPARSEC
    rLeUp :: Float64 # radius of the leading edge in the upper surface
    rLeLo :: Float64 # radius of the leading edge in the lower surface
    xUp :: Float64 # x coordinate of the maximum position of the upper surface
    zUp :: Float64 # z coordinate of the maximum position of the upper surface
    xLo :: Float64 # x coordinate of the minimum position of the lower surface
    zLo :: Float64 # z coordinate of the minimum position of the lower surface
    zXxup :: Float64 # curvature in the position of maximum thickness of the upper surface
    zXxlo :: Float64 # curvature in the position of maximum thickness of the lower surface
    zTe :: Float64 # z coordinate of the trailing edge
    ΔzTe :: Float64 # separation between the upper and lower surface in the trailing edge 
    αTe ::  Float64 # angle of the inclination of the mean chamber line in the tailing edge
    βTe :: Float64 # angle of separation of the upper and lower surface in the tailing edge
end

function coefUp(a::AirfoilPARSEC) :: Array{Float64}
    # A * coefUp = B
    A :: Array{Float64} = [
        1.0               1.0                1.0                1.0                1.0                1.0;
        a.xUp^(1/2)       a.xUp^(3/2)        a.xUp^(5/2)        a.xUp^(7/2)        a.xUp^(9/2)        a.xUp^(11/2);
        0.5               1.5                2.5                3.5                4.5                5.5;
        0.5*a.xUp^(-1/2)   1.5*a.xUp^(1/2)    2.5*a.xUp^(3/2)    3.5*a.xUp^(5/2)    4.5*a.xUp^(7/2)    5.5*a.xUp^(9/2);
        -0.25*a.xUp^(-3/2) 0.75*a.xUp^(-1/2) 3.75*a.xUp^(1/2)   8.75*a.xUp^(3/2)   15.75*a.xUp^(5/2)  24.75*a.xUp^(7/2);
        1.0               0.0                0.0                0.0                0.0                0.0
    ]


    B :: Array{Float64} = [a.zTe + 1/2*a.ΔzTe,
         a.zUp,
         tan(a.αTe - a.βTe/2),
         0,
         a.zXxup,
         sqrt(a.rLeUp)]

    return A \ B

end

function coefLow(a::AirfoilPARSEC) :: Array{Float64}
    # A * coefLow = B
    A :: Array{Float64} = [
        1.0               1.0                1.0                1.0                1.0                1.0;
        a.xLo^(1/2)       a.xLo^(3/2)        a.xLo^(5/2)        a.xLo^(7/2)        a.xLo^(9/2)        a.xLo^(11/2);
        0.5               1.5                2.5                3.5                4.5                5.5;
        0.5*a.xLo^(-1/2)   1.5*a.xLo^(1/2)    2.5*a.xLo^(3/2)    3.5*a.xLo^(5/2)    4.5*a.xLo^(7/2)    5.5*a.xLo^(9/2);
        -0.25*a.xLo^(-3/2) 0.75*a.xLo^(-1/2) 3.75*a.xLo^(1/2)   8.75*a.xLo^(3/2)   15.75*a.xLo^(5/2)  24.75*a.xLo^(7/2);
        1.0               0.0                0.0                0.0                0.0                0.0
    ]

    B :: Array{Float64} = [a.zTe - 1/2*a.ΔzTe;
         a.zLo;
         tan(a.αTe + a.βTe/2);
         0;
         a.zXxlo;
         -sqrt(a.rLeLo)]
        

    return A \ B

end

function main()
    exampleAirfoil = AirfoilPARSEC(0.02, 0.005, 0.43, 0.12, 0.23, -0.018, -0.8, 0.4, -0.001, 0, -5*π/180, 25*π/180)
    print(coefUp(exampleAirfoil))
    print()
    print(coefLow(exampleAirfoil))
    
end

main()

