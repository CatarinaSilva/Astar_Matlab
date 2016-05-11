function flag = isEqual(stateA , stateB)
% ISEQUAL
%   FLAG = ISEQUAL(STATEA, STATEB) returns true if
%   both states are equal
%
%   This is a dummy example
%   The opertions should be coherent with the type of node and actions
%   used.
%
%   See also COSTTOGO, GETHEURISTIC, GETNEIGHBOR, ISGOAL, ISVALID. 
    
    flag = 1;
    
    for i=1:length(stateA)
        if stateA(i) ~= stateB(i)
            flag = 0;
            break;
        end
    end
    

end