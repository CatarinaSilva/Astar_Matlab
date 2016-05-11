
function value = getHeuristic(node)

    % The function getHeuristic must be defined in a matlab script
    %
    % GET_HEURISTIC(NODE)
    %       RETURN VALUE 
    %
    % VALUE should be an underestimate of the cost of getting from the node
    % to any goal state
    %

    goal = [10 10];
    value = abs(goal(1)-node(1)) + abs(goal(2)-node(2));
            
end
