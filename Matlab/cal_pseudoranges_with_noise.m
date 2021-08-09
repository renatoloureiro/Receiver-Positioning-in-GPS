function [pseudoranges,pseudoranges_plus_noise]=...
    cal_pseudoranges_with_noise(sat,recetor, flag5)
    global sigma_eure t 

    c=(3*10^8);
    tu=10^-6; %atraso do relógio 
    for i=1:length(sat)
       pseudoranges(i)=sqrt((recetor.ecef.x - sat(i).x)^2  + ...
           (recetor.ecef.y - sat(i).y)^2  + (recetor.ecef.z - sat(i).z)^2) + c*tu ;  
       % atraso de 10^-6 [s] -> 1 ms
       % pseudoranges_plus_noise(i)= awgn(pseudoranges(i),-10*log10(7*sigma_eure/8)) + (awgn(pseudoranges(i),-10*log10(sigma_eure/8))- pseudoranges(i))*1.1/(sin(sat(i).elevation) + 0.1) ;
       
       % create slowly varying noise
       if flag5==1
            slow_noise(i)=awgn(pseudoranges(i),-10*log10(sigma_eure/8));
            pseudoranges_plus_noise(i)= awgn(pseudoranges(i),-10*log10(7*sigma_eure/8)) + flag5*(slow_noise(i)- pseudoranges(i))*1.1/(sin(sat(i).elevation) + 0.1) ;
       else
            slow_noise(i)=0;
            pseudoranges_plus_noise(i)= awgn(pseudoranges(i),-10*log10(sigma_eure));
       end
       
       
       
    end
    
    % pseudoranges_plus_noise=awgn(pseudoranges,-20); % 0.01
    

end