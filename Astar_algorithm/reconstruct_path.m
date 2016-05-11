
function path = reconstruct_path(cameFrom, current, actionsTook)

    currentID = current.id;
    total_path{1} = actionsTook{currentID};

    while ~isempty(cameFrom{currentID}) 
        currentID = cameFrom{currentID};
        if ~isempty(actionsTook{currentID})
            total_path{length(total_path)+1} = actionsTook{currentID};
        else
            break;
        end
    end
    
    path = total_path(end:-1:1);
    
end