function flag = isValid(state)
    
    global blocks;

    % The function isEqual must be defined in a matlab script
    %
    %  IS_EQUAL(A , B)
    %       RETURN 1 IF A==B
    %       RETURN 0 OTHERWISE
    %
    flag = 1;
    
    for i=1:length(blocks)
        if isEqual(state, blocks{i})
             flag = 0;
             break;
        end
    end
    

end