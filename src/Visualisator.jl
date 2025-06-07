using GLMakie
using LinearAlgebra

# Helper function to generate a voxelized sphere
function make_chunk_sphere(radius)
    r = LinRange(-radius, radius, 21)
    return [sqrt(x^2 + y^2 + z^2) for x in r, y in r, z in r], x -> x >= 1
end

function assign_voxel_position(x, y, z, size=2.0)
    hs = size/2.0
    return (x-hs, x+hs), (y-hs, y+hs), (z-hs, z+hs)
end

function make_voxel!(axis, x, y, z, size=2.0, voxel_function = make_chunk_sphere::Function, color=:blue)
    xs, ys, zs = assign_voxel_position(x, y, z, size)
    cube, limit_function = voxel_function(1.0)
    voxels!(axis, xs, ys, zs, cube, is_air = limit_function, color = color)
end

function visualize_multibody_voxels()
    # Create a scene
    f = Figure()
    ax = Axis3(f[1, 1])

    # Define origin ranges for placing the spheres at different locations
    r1 = (-10,10)
    r2 = (5,25)  # shift second sphere to avoid overlap

    # Plot both voxel volumes
    make_voxel!(ax, 1, 2, 3, 2.0, make_chunk_sphere, :red)

    display(f)
end

visualize_multibody_voxels()
