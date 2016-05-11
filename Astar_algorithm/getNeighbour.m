function next = getNeighbour(state , action)
% GETNEIGHBOR 
%   NEXT = GETNEIGHBOR(STATE, ACTION) returns next state of 
%   state obtained by applying action
%
%   This is a dummy example
%   The opertions should be coherent with the type of node and actions
%   used.
%
%   See also COSTTOGO, GETHEURISTIC, ISEQUAL, ISGOAL, ISVALID.    
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
