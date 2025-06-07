export newton

function newton(F, J, x0; tol::Real=1e-8, maxiter::Int=100)
    x = x0  # can be a scalar or vector
    for iter in 1:maxiter
        # Compute function and Jacobian
        local Fx = F(x)
        local Jx = J(x)
        # Solve Jx * Δ = Fx  (if scalar, this is just Δ = Fx/Jx)
        # In Julia, the "\" operator solves linear systems.
        Δ = Jx \ Fx  
        # Update estimate
        x = x - Δ
        # Check convergence (using norm for vector or abs for scalar)
        if (isa(Fx, Number) ? abs(Fx) : norm(Fx)) < tol
            return x, iter
        end
    end
    return x, maxiter
end


function newton(F::Function, J::Function, x0, settings::SolverSettings)
    return newton(F, J, x0, tol = settings.max_tolerance, maxiter = settings.max_iterations)
end