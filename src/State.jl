export State, init_state

struct State
    time::Float64
    q::Vector{Float64}

    function State(;time = 0, q = zeros(7))
        new(time, q)
    end
end

function init_state(bodies::Vector{Body})
    # Detect sizes of positional and rotational vectors
    pos_num = length(bodies[1].r)
    rot_num = length(bodies[1].e)
    # Caluclate the size of a body's state vector
    ove_num = pos_num + rot_num
    temp_q = zeros(ove_num*length(bodies))
    for (i, body) in enumerate(bodies)
        for (j, r) in enumerate(body.r)
            temp_q[(i-1)*ove_num+j] = r
        end
        for(j, e) in enumerate(body.e)
            temp_q[(i-1)*ove_num+pos_num+j] = e
        end
    end
    return State(time = 0, q = temp_q)
end

function get_index(body_pile::Vector{Body}, body::Body)
    # Detect sizes of positional and rotational vectors
    pos_num = length(bodies[1].r)
    rot_num = length(bodies[1].e)
    # Caluclate the size of a body's state vector
    ove_num = pos_num + rot_num
    # Find all matching objects
    list_of_matching_bodies = find(body, body_pile)
    # Return the first one (should be the only one)
    return list_of_matching_bodies[1]
end
