function sat=minimize_PDOP(view_satellites, pos,flag ,number_of_satellites)
    
    % signals if there is a number of satellites to choose
    % if flag==1 there is the constraint about the number of satellites to
    % use
    constraint(1)=flag; 
    constraint(2)=number_of_satellites;
    IntCon = 1:length(view_satellites);
    options = optimoptions('ga');
    options = optimoptions(options,'MaxGenerations', 20);
    options = optimoptions(options,'MaxStallGenerations', inf);
    options = optimoptions(options,'FunctionTolerance', 0);
    options = optimoptions(options,'ConstraintTolerance', 0);
    options = optimoptions(options,'Display', 'off');
    %options = optimoptions(options,'PlotFcn', { @gaplotbestf });
    % options = optimoptions(options,'MutationFcn',{@mutationgaussian,1,.5});
    [x,fval,exitflag,output,population,score] = ...
    ga(@(x)cost_funct(x,view_satellites,pos, constraint),...
    length(view_satellites),[],[],[],[], zeros(1,length(view_satellites)),...
    ones(1,length(view_satellites)),[],IntCon,options);
    % displays the binary sequence of which satellite is working
    % disp(x); 

    % NOTE:como o problema é discreto e existe um gradient descent possivel 
    % de aplicar, pode acontecer que às vezes poderá dar combinações 
    % diferentes de satelites, mas a diferença é diminuta
    % para o caso de 4 satelites é 001010010010 -> PDOP=2.54512
    
    % only get the satellites to work with
    j=1;
    for i=1:length(x)
        if x(i)==1
            sat(j)=view_satellites(i);
            j=j+1;
        end
    end


end