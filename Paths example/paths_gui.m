function astar_gui
    % ASTAR_PATHS_GUI Select an area and block some part of it, and add
    % a start and goal point. The point will move from start to goal in
    % the best path possible, finding it with Astar algorithm

    windowWidth = 1280;
    windowHeight = 720;
    marginWindow = 50;

    btnWidth = 150;
    btnHeight = 30;

    plotWidth = windowWidth - btnWidth - 3 * marginWindow;
    plotHeight = windowHeight - 2 * marginWindow;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                        %
    %                           UI AND PLOT WINDOW                           %
    %                                                                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
    figHandle = handle(figure(  'Visible','off', ...
                                'Position',[10, 10, windowWidth, windowHeight]));

    axesHandle = handle(axes('Units', 'pixels',  ...
                             'Position', [marginWindow, marginWindow, plotWidth , plotHeight]));
    hold on;

    
    % Initialize the UI.
    % Change units to normalized so components resize automatically.
    figHandle.Units = 'normalized';
    axesHandle.Units = 'normalized';                     


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                        %
    %                           RANGES AND ORIGINS                           %
    %                                                                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
    margin= 50;
    mg = margin/2;
    btnX = plotWidth+ 2* margin;  % X position for buttons
    btnY = margin;                % Y position for bottom button



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       Y RANGE BUTTON           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    areaYSliderText = uicontrol('Style','text', ... 
                                'String','Y range',...
                                'Position', [btnX, btnY + 0.6*btnHeight, btnWidth, btnHeight]);

    set(areaYSliderText,'backgroundcolor',get(figHandle,'color'))

    areaYSlider = uicontrol('Style', 'slider',...
                            'Min',10,   ...
                            'Max',30,  ...
                            'Value',12, ...
                            'Position', [btnX, btnY, btnWidth, btnHeight] , ...
                            'Callback', @yRange_Callback); 

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %       Y RANGE CALLBACK         %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
                function yRange_Callback(source, eventdata) 
                       y_range = get(source, 'Value');
                       ylim(axesHandle,[y_origin-1 y_origin+y_range+2]);
                       axesHandle.YTick = y_origin-0.5:1:y_origin+y_range+2+0.5;
                end



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       X RANGE BUTTON           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
    areaXSliderText = uicontrol('Style','text', ... 
                                'String','X range',...
                                'Position', [btnX, btnY+2.1*btnHeight+mg, btnWidth, btnHeight]);

    set(areaXSliderText,'backgroundcolor',get(figHandle,'color'));

    areaXSlider = uicontrol('Style', 'slider',...
                            'Min',10,   ...
                            'Max',40,  ...
                            'Value',12, ...
                            'Position', [btnX, btnY+1.5*btnHeight+mg, btnWidth, btnHeight],...
                            'Callback', @xRange_Callback); 

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %       X RANGE CALLBACK         %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
                function xRange_Callback(source, eventdata) 
                       x_range = get(source, 'Value');
                       xlim(axesHandle,[x_origin-1 x_origin+x_range+2]);
                       axesHandle.XTick = x_origin-0.5:1:x_origin+x_range+2+0.5
                end




    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       X ORIGIN BUTTON          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                         
    originXText = uicontrol('Style','text', ... 
                                  'String','X origin:',...
                                  'Position', [btnX, btnY+2.5*btnHeight+3*mg, btnWidth/2, 0.8*btnHeight]); 

    set(originXText,'backgroundcolor',get(figHandle,'color'))

    originX  = uicontrol('Style','edit',  ...
                         'String','0',...
                         'Position', [btnX+ btnWidth/2, btnY+2.5*btnHeight+3*mg, btnWidth/2, btnHeight], ...
                         'Callback', @xOrigin_Callback);

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %       X ORIGIN CALLBACK        %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
                function xOrigin_Callback(source, eventdata)    
                       str = get(source, 'String');
                       x_origin= str2num(str);
                       xlim(axesHandle,[x_origin-1 x_origin+x_range+2]);
                       axesHandle.XTick = x_origin-0.5:1:x_origin+x_range+2+0.5
                end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       Y ORIGIN BUTTON          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    originYText = uicontrol('Style','text', ... 
                                  'String','Y origin:',...
                                  'Position', [btnX, btnY+3.7*btnHeight+3*mg, btnWidth/2,  0.8*btnHeight]); 

    set(originYText,'backgroundcolor',get(figHandle,'color'))

    originY = uicontrol('Style','edit',  ...
                         'String','0',...
                         'Position', [btnX+ btnWidth/2, btnY+3.7*btnHeight+3*mg, btnWidth/2, btnHeight], ...
                         'Callback', @yOrigin_Callback); 

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %       Y ORIGIN CALLBACK        %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
                function yOrigin_Callback(source, eventdata)          
                       str = get(source, 'String');
                       y_origin= str2num(str);
                       ylim(axesHandle,[y_origin-1 y_origin+y_range+2]);
                       axesHandle.YTick = y_origin-0.5:1:y_origin+y_range+2+0.5
                end

    align([areaXSliderText, areaXSlider,areaYSliderText,areaYSlider],'Center','None');        
    align([originX, originY],'Center','None');
    align([originXText, originYText],'Center','None');
    align([originXText, originX],'None','Center');
    align([originYText, originY],'None','Center');

    areaXSliderText.Units = 'normalized';
    areaXSlider.Units = 'normalized';
    areaYSliderText.Units = 'normalized';
    areaYSlider.Units = 'normalized';
    originXText.Units = 'normalized';
    originX.Units = 'normalized';
    originYText.Units = 'normalized';
    originY.Units = 'normalized';


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                        %
    %                       START AND GOAL NODES                             %
    %                                                                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    startNode    = uicontrol('Style','pushbutton', ...
                              'String','Select start', ...
                              'Position', [btnX, btnY+5.2*btnHeight+5*mg, btnWidth, btnHeight],...
                              'Callback', @selectstart_Callback);
    startN = [];                  
    set(startNode, 'backgroundcolor',[0.9 0.3 0.3]);
    handleStart = handle(plot(0,0));
    set( handleStart, 'Xdata', [], 'Ydata', [] )

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %     START ORIGIN CALLBACK      %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
                function selectstart_Callback(source, eventdata)    
                       set(source, 'backgroundcolor',[1 0.9 0.2]);
                       startN = ginput(1);
                       
                       startN = round(startN);
                       set(handleStart, 'Xdata', [startN(1)], 'Ydata', [startN(2)], 'Marker', '*');
                       flagSt = 1;
                       set(source, 'backgroundcolor',[0.2 0.8 0.2]);
                end
                          
                          
    goalNode    = uicontrol('Style','pushbutton', ...
                              'String','Select goal', ...
                              'Position', [btnX, btnY+4*btnHeight+5*mg, btnWidth, btnHeight],...
                              'Callback', @selectgoal_Callback);
    goalN = [];                      
    set(goalNode, 'backgroundcolor',[0.9 0.3 0.3]);
    handleGoal = handle(plot(0,0));
    set( handleGoal, 'Xdata', [], 'Ydata', [] )

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %      GOAL ORIGIN CALLBACK      %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
                function selectgoal_Callback(source, eventdata)    
                       set(source, 'backgroundcolor',[1 0.9 0.2]);
                       goalN = ginput(1);
                       
                       goalN = round(goalN);
                       set(handleGoal, 'Xdata', [goalN(1)], 'Ydata', [goalN(2)], 'Marker', '*');
                       set(handleGoal,'Color','red')
                       flagGl = 1;
                       set(source, 'backgroundcolor',[0.2 0.8 0.2]);
                end




    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                        %
    %                           BLOCKED AREA                                 %
    %                                                                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    blockText = uicontrol('Style','text', ... 
                            'String','# squares to lock:',...
                            'Position', [btnX, btnY+16*btnHeight+5*mg, btnWidth, btnHeight]); 

    set(blockText,'backgroundcolor',get(figHandle,'color'))

    blockNum = uicontrol('Style','edit',  ...
                         'String','0',...
                         'Position', [btnX, btnY+15*btnHeight+5*mg, btnWidth, btnHeight]); 

    block  = uicontrol('Style','pushbutton', ...
                              'String','Block', ...
                              'Position', [btnX, btnY+12*btnHeight+5*mg, btnWidth, 2*btnHeight],...
                              'Callback', @block_Callback);
                          
    set(block, 'backgroundcolor',get(figHandle,'color'));  
    global hBlocks;
    hBlocks = [];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %          BLOCK CALLBACK        %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
                function block_Callback(source, eventdata)    
                       
                       str = get(blockNum, 'String');
                       num = str2num(str);

                       if num==0                                                 
                           for k=1:length(hBlocks)
                                delete(hBlocks(k));
                           end
                            blocks = {};
                            blocks2lock = [];
                       elseif num < length(blocks) | length(blocks) == 0
                           for k=1:length(hBlocks)
                                delete(hBlocks(k));
                           end
                           blocks = {};
                           blocks2lock = ginput(num);
                       else
                           num = abs(length(blocks) - num);
                           blocks2lock = ginput(num);
                           for k=1:length(hBlocks)
                                delete(hBlocks(k));
                           end
                       end
                       hBlocks = [];
                       for i=1:num
                           blocks{end+1} = round(blocks2lock(i,:));
                       end
                        
                       
                       for k=1:length(blocks)
                            hBlocks(k) = handle(fill([blocks{k}(1)-0.5 , blocks{k}(1)+0.5,blocks{k}(1)+0.5 ,blocks{k}(1)-0.5 ],[blocks{k}(2)-0.5 , blocks{k}(2)-0.5 ,  blocks{k}(2)+0.5, blocks{k}(2)+0.5],'k'));
                       end
                       
                end

    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                        %
    %                           RUN THE ALGORITHM                            %
    %                                                                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    run  = uicontrol('Style','pushbutton', ...
                              'String','Run A-star', ...
                              'Position', [btnX, btnY+8*btnHeight+5*mg, btnWidth, 2*btnHeight],...
                              'Callback', @run_Callback);
                          
    set(run, 'backgroundcolor',[0.9 0.3 0.3]);  
    
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %           RUN CALLBACK         %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
                function run_Callback(source, eventdata)  
                    
                       if ~flagGl | ~flagSt
                            set(source, 'backgroundcolor',[0.9 0.3 0.3]); 
                       else
                            set(source, 'backgroundcolor',[1 0.9 0.2]);
                            
                            global goal;
                            goal = goalN;
                            path=Astar(startN, {'left', 'right', 'up', 'down'});
                            
                            if isempty(path)
                                set(source, 'backgroundcolor',[0.9 0.3 0.3]); 
                            else
                                state = startN;
                                h3 = handle(plot(state(1),state(2),'b*'));
                                for i=1:length(path)
                                    state = getNeighbour(state, path{i});

                                    h3.XData = state(1);
                                    h3.YData = state(2);
                                    drawnow;

                                    pause(0.7);
                                end
                                set(source, 'backgroundcolor',[0.2 0.8 0.2]);
                                h3.XData = [];
                                h3.YData = [];
                            end
                            
                       end                  
                end
    
        
    
    
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                        %
    %                         INITIAL SETTING                                %
    %                                                                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    % Generate the data to plot.
    x_origin = 0;
    y_origin = 0;
    x_range = 10;
    y_range = 10;
    xlim(axesHandle,[x_origin-1 x_origin+x_range+2]);
    ylim(axesHandle,[y_origin-1 y_origin+y_range+2]);
    
    grid minor 
    axesHandle.XTick = x_origin:1:x_origin+x_range+2
    axesHandle.YTick = y_origin:1:y_origin+y_range+2
    axesHandle.XMinorTick = 'off';
    axesHandle.YMinorTick = 'off';    

    flagSt = 0; %start selected
    flagGl = 0; %goal selected

    global blocks;
   
    blocks = {};
    for k=1:length(blocks)
        h4 = handle(fill([blocks{k}(1)-0.5 , blocks{k}(1)+0.5,blocks{k}(1)+0.5 ,blocks{k}(1)-0.5 ],[blocks{k}(2)-0.5 , blocks{k}(2)-0.5 ,  blocks{k}(2)+0.5, blocks{k}(2)+0.5],'k'));
    end
                       
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                        %
    %                            STARTING UP                                 %
    %                                                                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

    % Assign the a name to appear in the window title.
    figHandle.Name = 'Astar Paths GUI';

    % Move the window to the center of the screen.
    movegui(figHandle,'center')

    % Make the window visible.
    figHandle.Visible = 'on';


end