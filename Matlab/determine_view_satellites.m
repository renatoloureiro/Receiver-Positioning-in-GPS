%   'PRN' é a estrutura com a informação total dos satellites - com a posição 
%   dos satellites atualizados 
%   'pos' é a variavel com a posição estimada do recetor para determinar os
%   satelites visiveis
%   'mask_angle' é a inclinação limite para ser considerado como visivel 

function [view_satellites]=determine_view_satellites(PRN,pos,mask_angle)
    global deg

    % enu: position relative to the reference position
    for i=1:length(PRN) 
        PRN(i).enu=pos.ECEF_ENU*[PRN(i).x-pos.ecef.x;...
            PRN(i).y-pos.ecef.y;PRN(i).z-pos.ecef.z];
    end

    % calculate the elevation of each satellite
    j=1;
    for i=1:length(PRN)
       PRN(i).elevation=asin(PRN(i).enu(3)/sqrt(PRN(i).enu(1)^2 + ...
           PRN(i).enu(2)^2 + PRN(i).enu(3)^2));
       if PRN(i).elevation>mask_angle*deg
            view_index(j)=i;
            j=j+1;
       end
    end

    % seems to be working
%     for i=view_index
%         scatter3([PRN(i).x],[PRN(i).y],[PRN(i).z])
%         hold on
%     end

    % A structure only having the satellites in view
    for i=1:length(view_index)
       view_satellites(i)=PRN(view_index(i));
    end

end