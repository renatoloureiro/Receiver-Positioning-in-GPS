function data_gps=LS_data_velocities(data_gps)
    global dt
    data_gps.LS.ecef.vx = gradient(data_gps.LS.ecef.x,dt);
    data_gps.LS.ecef.vy = gradient(data_gps.LS.ecef.y,dt);
    data_gps.LS.ecef.vz = gradient(data_gps.LS.ecef.z,dt);
    
    data_gps.LS.enu.vx = gradient(data_gps.LS.enu.x,dt);
    data_gps.LS.enu.vy = gradient(data_gps.LS.enu.y,dt);
    data_gps.LS.enu.vz = gradient(data_gps.LS.enu.z,dt);

end