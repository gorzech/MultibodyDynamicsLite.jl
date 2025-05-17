export SolverSettings

Base.@kwdef struct SolverSettings
    start_time_s::Float64 = 0.0
    end_time_s::Float64 = 1.0
    time_step_s::Float64 = 0.01
    max_tolerance::Float64 = 1e-6
    max_iterations::Int = 100
end







