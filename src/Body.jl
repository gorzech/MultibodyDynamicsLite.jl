export Body

struct Body
    r::Vector{Float64}  # position: x, y, z
    e::Vector{Float64}  # unit quaternion: e0, ex, ey, ez

    function Body(r::Vector{Float64}, e::Vector{Float64})
        norme = norm(e)
        if iszero(norme)
            throw(ArgumentError("Quaternion e is invalid (zero vector)"))
        end
        e = e / norme
        new(r, e)
    end
end

Body() = Body([0.0, 0.0, 0.0], [1.0, 0.0, 0.0, 0.0])