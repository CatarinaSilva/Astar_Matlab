function flag = isEqual(stateA , stateB)
               
    % The function isEqual must be defined in a matlab script
    %
    %  IS_EQUAL(A , B)
    %       RETURN 1 IF A==B
    %       RETURN 0 OTHERWISE
    %
    
    flag = 1;
    
    for i=1:length(stateA)
        if stateA(i) ~= stateB(i)
            flag = 0;
            break;
        end
    end
    

end