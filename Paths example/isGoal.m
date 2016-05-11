function flag = isGoal(node)
    global goal
    % The function isGoal must be defined in a matlab script
    %
    % IS_GOAL(NODE)
    %       RETURN 0   IF NODE ~=  GOAL
    %       RETURN 1   IF NODE ==  GOAL
    %

    flag = 0;
    
    if node(1) == goal(1)
        if node(2) == goal(2)
            flag = 1;
        end
    end
    

end
