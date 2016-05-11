function idFinal = minimum_fscore_node(openSet, fScore)
% ISVALID
%   FLAG = % ISVALID(STATE) returns true if
%   node is valid
%
%   This is a dummy example
%   The opertions should be coherent with the type of node and actions
%   used.
%
%   See also COSTTOGO, GETHEURISTIC, GETNEIGHBOR, ISEQUAL, ISGOAL. 

min = Inf;
idFinal = 1;

for i=1:length(openSet)
    curr = openSet{i};
    if ~isempty(curr)
        id = i;
        if fScore{id} <= min
            min = fScore{id};
            idFinal = id;
        end  
    end
end


end