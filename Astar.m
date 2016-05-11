function [path , flag] = Astar(initial, actions)
   
    % The function isGoal must be defined in a matlab script
    %
    % IS_GOAL(NODE)
    %       RETURN 0   IF NODE ~=  GOAL
    %       RETURN 1   IF NODE ==  GOAL
    %
    if isGoal(initial);
        path = [];
        flag = 1;
    else
        numActions = length(actions);
            
        %define OPEN and CLOSE
        closedSet = {};
        openSet = {};
        cameFrom = {};
        actionsTook = {};
        gScore = {};
        fScore = {};
        
        %give each state an additive ID for use in gscore, fscore and cameFrom
        lastId = 0;
        start.id = lastId+1;
        start.node = initial;

        lastId = start.id;    

        openSet{start.id} = start; 
        cameFrom{start.id} = [];
        actionsTook{start.id} = [];
        gScore{start.id} = 0;

        % The function getHeuristic must be defined in a matlab script
        %
        % GET_HEURISTIC(NODE)
        %       RETURN VALUE 
        %
        % VALUE should be an underestimate of the cost of getting from the node
        % to any goal state
        %
        fScore{start.id} = getHeuristic(start.node);

        
        path = [];
        flag = 0;
        while ~isempty(find(~cellfun(@isempty, openSet)))
            currentIndex = minimum_fscore_node(openSet, fScore);
            current = openSet{currentIndex};
           
            if isGoal(current.node);
                path = reconstruct_path(cameFrom, current, actionsTook);
                flag = 1;
                break;
            end

            openSet{current.id} = []; % remove current from OPEN
            closedSet{current.id} = current;

            
            for iAction=1:1:numActions        
                actionTook = actions{iAction};
           
                neighbor.node = getNeighbour(current.node, actionTook);
                if ~isempty(neighbor.node)
                    neighbourVisited = 0;
                    for j=1:length(closedSet)
                        % The function getHeuristic must be defined in a matlab script
                        %
                        %  IS_EQUAL(A , B)
                        %       RETURN 1 IF A==B
                        %       RETURN 0 OTHERWISE
                        %
                        if ~isempty(closedSet{j})
                            if isEqual(closedSet{j}.node, neighbor.node)
                                neighbourVisited = 1;
                            end
                        end                  
                    end

                    if neighbourVisited
                        continue;		% Ignore the neighbor which is already evaluated.
                    end

                    % The function costToGo must be defined in a matlab script
                    %
                    %  COST_TO_GO(A , ACTION)
                    %       RETURN VALUE
                    %
                    % where VALUE is the cost from applying ACTION to A
                    %
                    tentative_gScore = gScore{current.id} + costToGo(current.node, actionTook);
                    
                    neighbor.id = 0;
                    for j=1:length(openSet)
                        if ~isempty(openSet{j})
                            if isEqual(openSet{j}.node, neighbor.node)
                                neighbor.id = openSet{j}.id;
                                break;
                            end
                        end
                    end            


                    if neighbor.id == 0  % Discover a new node
                        neighbor.id = lastId + 1;
                        lastId = neighbor.id;
                        openSet{neighbor.id} = neighbor;
                    else
                        if tentative_gScore >= gScore{neighbor.id}
                            continue;                                 %	// This is not a better path.
                        end
                    end
                    
                    % This path is the best until now. Record it!
                    cameFrom{neighbor.id} = current.id;
                    gScore{neighbor.id} = tentative_gScore;
                    fScore{neighbor.id} = gScore{neighbor.id} + getHeuristic(neighbor.node);
                    actionsTook{neighbor.id} = actionTook;
                else
                    disp('blocked')
                end
          
            end

        end
    end
end


