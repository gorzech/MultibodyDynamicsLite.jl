export newton

"""
    newton(f, dfdx, x0, tol; maxiter=100) → (root, n_iters)

Newton–Raphson solver that throws on bad iterates or no convergence:

# Arguments
- `f(x)`       : function
- `dfdx(x)`    : its derivative
- `x0`         : initial guess
- `tol`        : |f(x)| tolerance for convergence
- `maxiter`    : maximum allowed iterations (keyword)

# Returns
- `(root, n_iters)`

# Throws
- `ErrorException` if `x` becomes NaN/Inf or if it fails to converge within `maxiter`.
"""
function newton(f::Function, dfdx::Function, x0::Float64, tol::Float64=1e-10; maxiter::Int=100)
    x    = x0
    fval = f(x)
    iter = 0

    while abs(fval) > tol && iter < maxiter
        x_new = x - fval / dfdx(x)
        if isnan(x_new) || isinf(x_new)
            throw(ErrorException("Newton diverged: x became $x_new at iteration $iter"))
        end
        x    = x_new
        fval = f(x)
        iter += 1
    end

    if abs(fval) > tol
        throw(ErrorException("Newton did not converge in $maxiter iterations (|f(x)| = $fval > $tol)"))
    end

    return x, iter
end

function newton(f::Function, dfdx::Function, x0::Float64, settings::SolverSettings)
    return newton(f, dfdx, x0, settings.max_tolerance, maxiter = settings.max_iterations)
end

"""
    newton_system(F, J, x0; tol=1e-8, maxiter=100)

Solve the nonlinear system F(x) = 0 via Newton–Raphson:

- `F(x)` returns a vector of length m.
- `J(x)` returns the m×m Jacobian matrix.
- `x0` is your initial guess (length-m vector).
- `tol` is the convergence tolerance on ‖F(x)‖₂.
- `maxiter` is the maximum number of iterations.

Returns `(root, n_iter)`.  
Throws an `ErrorException` if the method fails to converge within `maxiter` iterations,
or if the Jacobian becomes singular.
"""
function newton(F::Function, J::Function, x0::Vector{Float64}, tol::Float64=1e-10; maxiter::Int=100)

    # work on a copy so we don't mutate the input
    x = copy(x0)
    for iter in 1:maxiter
        Fx = F(x)
        Fnorm = norm(Fx)
        if Fnorm ≤ tol
            return x, iter-1
        end
        # solve J(x)*Δ = -F(x)
        Δ = -J(x) \ Fx
        x += Δ
    end

    # if we get here, we exceeded maxiter without convergence
    final_norm = norm(F(x))
    throw(ErrorException(
        "Newton–Raphson failed to converge after $maxiter iterations; " *
        "‖F(x)‖ = $final_norm > $tol"
    ))
end

function newton(f::Function, dfdx::Function, x0::Vector{Float64}, settings::SolverSettings)
    return newton(f, dfdx, x0, settings.max_tolerance, maxiter = settings.max_iterations)
end
