function flag = isGoal(node)
% ISGOAL
%   FLAG = ISGOAL(NODE) returns true if
%   node is a goal node
%
%   This is a dummy example
%   The opertions should be coherent with the type of node and actions
%   used.
%
%   See also COSTTOGO, GETHEURISTIC, GETNEIGHBOR, ISEQUAL, ISVALID. 

    global goal
    flag = 0;
    
    if isEqual(node, goal)
        flag = 1;
    end
    

end
