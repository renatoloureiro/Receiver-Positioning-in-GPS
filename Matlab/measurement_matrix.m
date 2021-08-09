function R=measurement_matrix(elevation,desvio_padrao_squared)

for i=1:length(elevation)
    for j=1:length(elevation)
    if i==j
       R(i,j)=(desvio_padrao_squared/8)*(7 + ...
           1.21/(sin(elevation(i)) + 0.1)^2); 
    else
        R(i,j)=(desvio_padrao_squared/8)*1.21/((sin(elevation(i))+ 0.1)...
            *(sin(elevation(j))) + 0.1);
    end
    end
end

end