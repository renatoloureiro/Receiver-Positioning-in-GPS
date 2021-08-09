function sat=canyon_scenario(flag3, PRN, pos_A,sat)

    
     PRN=update_satellites_position(PRN,pos_A);
     aux2=[PRN.elevation];
     aux3=1:length(PRN);
           
     for i=1:4
        [M,I]=max(aux2);
        aux4(i)=aux3(I);
        aux2(I)=[];
        aux3(I)=[];
     end
     clear sat
     for i=1:4
        sat(i)=PRN(aux4(i)); 
     end
     flag3=0;
       
end