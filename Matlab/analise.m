load('case1.mat')
load('case2.mat')
load('case3.mat')
load('case4.mat')
load('case5.mat')
load('case6.mat')
load('case7.mat')
load('case8.mat')
load('case9.mat')
load('data_ori.mat') % só para obter a trajetória tem tudo incluido

color1=[0 0.4470 0.7410];
color2=[0.6350 0.0780 0.1840];
color3=[0.4660 0.6740 0.1880];
color4=[0.8500 0.3250 0.0980];

%% Comparar o case1 com case4 
figure(1)
    plot(0:0.5:490, case1.Var_x)
    hold on
    plot(0:0.5:490, case4.Var_x)
figure(2)
    plot(0:0.5:490, case1.Var_y)
    hold on
    plot(0:0.5:490, case4.Var_y)
figure(3)
    plot(0:0.5:490, case1.Var_z)
    hold on
    plot(0:0.5:490, case4.Var_z)
figure(4)
    plot(0:0.5:490, case1.Var_vx)
    hold on
    plot(0:0.5:490, case4.Var_vx)
figure(5)
    plot(0:0.5:490, case1.Var_vy)
    hold on
    plot(0:0.5:490, case4.Var_vy)
figure(6)
    plot(0:0.5:490, case1.Var_vz)
    hold on
    plot(0:0.5:490, case4.Var_vz)
%%  Comparar o case1 com case4 -> comparar o Kalman filter com o LS tudo ativo 
figure(7)
    plot(0:0.5:490, sqrt(case1.Var_x + case1.Var_y + case1.Var_z))
    hold on
    plot(0:0.5:490, sqrt(case4.Var_x + case4.Var_y + case4.Var_z))
    
figure(8)
    plot(0:0.5:490, sqrt(case1.Var_vx + case1.Var_vy + case1.Var_vz))
    hold on
    plot(0:0.5:490, sqrt(case4.Var_vx + case4.Var_vy + case4.Var_vz))

%% Comparar case1 e case2 (comparação de slow noise em kalman)

h=figure(9)
    plot(0:0.5:490, sqrt(case16.Var_x + case16.Var_y + case16.Var_z),'Color',color2)
    hold on
    plot(0:0.5:490, sqrt(case17.Var_x + case17.Var_y + case17.Var_z),'Color',color3)
    legend('Kalman filter with ñ', 'Kalman filter without ñ ')
    xlabel('Time [s]')
    ylabel('Position rms error [m]')
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h,'fig24','-dpdf','-r0');
    
h1=figure(10)
    plot(0:0.5:490, sqrt(case16.Var_vx + case16.Var_vy + case16.Var_vz),'Color',color2)
    hold on
    plot(0:0.5:490, sqrt(case17.Var_vx + case17.Var_vy + case17.Var_vz),'Color',color3)
    legend('Kalman filter with ñ', 'Kalman filter without ñ ')
    xlabel('Time [s]')
    ylabel('Velocity rms error [m/s]')
    set(h1,'Units','Inches');
    pos = get(h1,'Position');
    set(h1,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h1,'fig25','-dpdf','-r0');
%% comparar case1 e case3 -> existencia de canyon no kalman

h=figure(11)
    plot(0:0.5:490, sqrt(case16.Var_x + case16.Var_y + case16.Var_z),'Color',color2)
    hold on
    plot(0:0.5:490, sqrt(case18.Var_x + case18.Var_y + case18.Var_z),'Color',color1)
    legend('Kalman filter with canyon', 'Kalman filter without canyon ')
    xlabel('Time [s]')
    ylabel('Position rms error [m]')
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h,'fig26','-dpdf','-r0');
    
h1=figure(12)
    plot(0:0.5:490, sqrt(case16.Var_vx + case16.Var_vy + case16.Var_vz),'Color',color2)
    hold on
    plot(0:0.5:490, sqrt(case18.Var_vx + case18.Var_vy + case18.Var_vz),'Color',color1)
    legend('Kalman filter with canyon', 'Kalman filter without canyon ')
    xlabel('Time [s]')
    ylabel('Velocity rms error [m/s]')
    set(h1,'Units','Inches');
    pos = get(h1,'Position');
    set(h1,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h1,'fig27','-dpdf','-r0');
    
%% comparar LS e Kalman sem canyon (case3 e case6)

h1=figure(13)
    plot(0:0.5:490, sqrt(case18.Var_x + case18.Var_y + case18.Var_z),'Color',color2)
    hold on
    plot(0:0.5:490, sqrt(case6.Var_x + case6.Var_y + case6.Var_z),'Color',color3)
    legend('Kalman filter', 'Least Squares')
    xlabel('Time [s]')
    ylabel('Position rms error [m]')
    set(h1,'Units','Inches');
    pos = get(h1,'Position');
    set(h1,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h1,'fig22','-dpdf','-r0');
    
h=figure(14)
    plot(0:0.5:490, sqrt(case18.Var_vx + case18.Var_vy + case18.Var_vz),'Color',color2)
    hold on
    plot(0:0.5:490, sqrt(case6.Var_vx + case6.Var_vy + case6.Var_vz),'Color',color3)
    legend('Kalman filter', 'Least Squares')
    xlabel('Time [s]')
    ylabel('Velocity rms error [m/s]')
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h,'fig23','-dpdf','-r0');
%% comparação da existencia de canyon no least squares

h1=figure(15)
    plot(0:0.5:490, sqrt(case4.Var_x + case4.Var_y + case4.Var_z),'Color',color2)
    hold on
    plot(0:0.5:490, sqrt(case6.Var_x + case6.Var_y + case6.Var_z),'Color',color3)
    legend('Least Squares with canyon', 'Least Squares without canyon ')
    xlabel('Time [s]')
    ylabel('Position rms error [m]')
    set(h1,'Units','Inches');
    pos = get(h1,'Position');
    set(h1,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h1,'fig7','-dpdf','-r0');
    
h=figure(16)
    plot(0:0.5:490, sqrt(case4.Var_vx + case4.Var_vy + case4.Var_vz),'Color',color2)
    hold on
    plot(0:0.5:490, sqrt(case6.Var_vx + case6.Var_vy + case6.Var_vz),'Color',color3)
    legend('Least Squares with canyon', 'Least Squares without canyon ')
    xlabel('Time [s]')
    ylabel('Velocity rms error [m/s]')
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h,'fig8','-dpdf','-r0');
    
 %% expect value of trajectory
 
 h=figure(17)
    plot(case1.E_x,case1.E_y, 'Color', color2)
    hold on
    plot(case4.E_x,case4.E_y, 'Color', color3)
    plot(data_gps.receiver_orig.enu.x,data_gps.receiver_orig.enu.y, 'Color', color1)
    legend('Kalman filter', 'Least Squares', 'Original')
    xlabel('E\{x\} [m]')
    ylabel('E\{y\} [m]')
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h,'fig9','-dpdf','-r0');
 
 %% tudo sem expected trajetoria
 
 h=figure(18)
    plot(data_gps.kalman.enu.x,data_gps.kalman.enu.y, 'Color', color2)
    hold on
    plot(data_gps.LS.enu.x,data_gps.LS.enu.y, 'Color', color3)
    plot(data_gps.receiver_orig.enu.x,data_gps.receiver_orig.enu.y, 'Color', color1)
    legend('Kalman filter', 'Least Squares', 'Original')
    xlabel('x [m]')
    ylabel('y [m]')
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    %print(h,'fig11','-dpdf','-r0');
 
%% Velocidades

h=figure(19)
    plot(0:0.5:490, data_gps.LS.enu.vz, 'Color', color3)
    hold on
    plot(0:0.5:490, data_gps.kalman.enu.vz, 'Color', color2)
    legend('Least Squares','Kalman filter')
    xlabel('Time [s]')
    ylabel('Velocity [m/s]')
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h,'fig30','-dpdf','-r0');
 
    
 %% comparar com o numero de satelites usados no kalman filter (position)
 
 h=figure(20)
    plot(0:0.5:490, sqrt(case7.Var_x + case7.Var_y + case7.Var_z), 'Color', color2)
    hold on
    plot(0:0.5:490, sqrt(case8.Var_x + case8.Var_y + case8.Var_z), 'Color', color3)
    plot(0:0.5:490, sqrt(case9.Var_x + case9.Var_y + case9.Var_z), 'Color', color1)
    legend('4 Satellites', '6 Satellites', '8 Satellites')
    xlabel('Time [s]')
    ylabel('Position rms error [m]')
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h,'fig17','-dpdf','-r0');
%% comparar com o numero de satelites usados no kalman filter (velocity)
h=figure(21)
    plot(0:0.5:490, sqrt(case7.Var_vx + case7.Var_vy + case7.Var_vz), 'Color', color2)
    hold on
    plot(0:0.5:490, sqrt(case8.Var_vx + case8.Var_vy + case8.Var_vz), 'Color', color3)
    plot(0:0.5:490, sqrt(case9.Var_vx + case9.Var_vy + case9.Var_vz), 'Color', color1)
    legend('4 Satellites', '6 Satellites', '8 Satellites')
    xlabel('Time [s]')
    ylabel('Velocity rms error [m]')
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
    print(h,'fig18','-dpdf','-r0');

    
    
    