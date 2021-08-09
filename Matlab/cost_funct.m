function cost=cost_funct(on_off,view_satellites,pos, constraint)
    
    j=1;
    if sum(on_off)>=4
        for i=1:length(on_off)
            if on_off(i)==1
                r=sqrt((view_satellites(i).x - pos.ecef.x)^2 + (view_satellites(i).y ...
                    - pos.ecef.y)^2 + (view_satellites(i).z - pos.ecef.z)^2);
                H(j,1)=(view_satellites(i).x - pos.ecef.x)/r;
                H(j,2)=(view_satellites(i).y ...
                    - pos.ecef.y)/r;
                H(j,3)=(view_satellites(i).z - pos.ecef.z)/r;
                H(j,4)=-1;
                j=j+1;
            end
        end
        M_GDOP=inv(H'*H);
        PDOP=sqrt(M_GDOP(1,1) + M_GDOP(2,2) + M_GDOP(3,3));
        cost=PDOP;
    else
       cost=inf;
    end
    
    if constraint(1)==1 % if there is a constraint about the number of satellites to use
        if sum(on_off)~=constraint(2)
            cost=inf;
        end
    end

end