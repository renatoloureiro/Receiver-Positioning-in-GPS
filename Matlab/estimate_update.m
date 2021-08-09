function x_upd = estimate_update(x, z, pseudoranges, K)

    x_upd = x+ K*(pseudoranges - z); 

end