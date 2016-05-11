function next = getNeighbour(state , action)
    % The function getNeighbour must be defined in a matlab script
    %
    %  GET_NEIGHBOUR(A , action)
    %       RETURN B
    %
    % where B is a neighbor of A
    % B should be of same type as A
    %
    
    if strcmp(action,'right')
        next = state + [1 0];
    end
    
    if strcmp(action,'left')
        next = state + [-1 0];
    end
    
    if strcmp(action,'up')
        next = state + [0 1];
    end
    
    if strcmp(action,'down')
        next = state + [0 -1];
    end

    if ~isValid(next)
        next = [];
    end
    
end
