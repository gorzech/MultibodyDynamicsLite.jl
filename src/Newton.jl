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