function a_post_process(para,save_mode,path)
if nargin<2
    save_mode =0;
end
    y = para.y;
    th = para.th;
    Jx = para.result.Jx;
    Jy = para.result.Jy;
    Ex = para.Ex;
    h = para.hNew;
    h0 = para.HydroModes(:,1);
    hx = para.HydroModes(:,2);
    hy = para.HydroModes(:,3);
    Ey = para.src.Ey;

   
if save_mode&&para.SCInfo.trackitr
     h1 = figure;
    tiledlayout(3,2);
    nexttile
    yyaxis left
    plot(y,Jx,'Marker','o','MarkerEdgeColor','b',...
        'Color','b','MarkerEdgeColor','k','MarkerFaceColor','b');
    hold on;
    xlabel('y/W')
    ylabel('J_x(y)')
    yyaxis right
    plot(y,Jy,'Marker','square','MarkerEdgeColor','r',...
        'Color','r','MarkerEdgeColor','k','MarkerFaceColor','r');
    ylabel('J_y(y)')
    title('Current profile')

    
    nexttile
    plot(y,Ey/Ex,'Marker','o','MarkerEdgeColor','b',...
        'Color','b','MarkerEdgeColor','k','MarkerFaceColor','b');
    xlabel('y/W')
    ylabel('Ey(y)/Ex')
    title('Hall electric field')
    nexttile
    imagesc(th,y,h);
    cmap(h);
    ylabel('y/W');
    xlabel('\theta')
    title('distribution function h(y,\theta)')
    colorbar;

    nexttile
    plot(y,h0,'Marker','x','Markersize',8);
    hold on
    plot(y,hx,'Marker','o','Markersize',3);
    plot(y,hy,'Marker','o','Markersize',3);
    legend('h_0','h_x','h_y')
    title('Hydrodynamic projections')
    xlabel('y/W');
    ylabel('h_i(y)')

    nexttile
    quiver(para.FSInfo.XY(:,1),para.FSInfo.XY(:,2),para.FSInfo.VFxy(:,1),para.FSInfo.VFxy(:,2));
    xlabel('k_x');
    ylabel('k_y');
    title('FS and v_F')

    nexttile 
    plot(1 : para.SCInfo.itr, para.SCInfo.loss(1 : para.SCInfo.itr),'Marker','o','Markersize',10,'MarkerFaceColor','b');
    xlabel('iterations')
    ylabel('relative loss')
    if ~exist(path,'dir')
        mkdir(path);
    end
    savefig(h1,[path,'/results.fig'],'compact');
    save([path,'/para.mat'],"para");
    close gcf
elseif save_mode&&(~para.SCInfo.trackitr)
   
     if ~para.SCInfo.Flag
           h1 = figure;
    tiledlayout(3,2);
    nexttile
    yyaxis left
    plot(y,Jx,'Marker','o','MarkerEdgeColor','b',...
        'Color','b','MarkerEdgeColor','k','MarkerFaceColor','b');
    hold on;
    xlabel('y/W')
    ylabel('J_x(y)')
    yyaxis right
    plot(y,Jy,'Marker','square','MarkerEdgeColor','r',...
        'Color','r','MarkerEdgeColor','k','MarkerFaceColor','r');
    ylabel('J_y(y)')
    title('Current profile')

    
    nexttile
    plot(y,Ey/Ex,'Marker','o','MarkerEdgeColor','b',...
        'Color','b','MarkerEdgeColor','k','MarkerFaceColor','b');
    xlabel('y/W')
    ylabel('Ey(y)/Ex')
    title('Hall electric field')
    nexttile
    imagesc(th,y,h);
    cmap(h);
    ylabel('y/W');
    xlabel('\theta')
    title('distribution function h(y,\theta)')
    colorbar;

    nexttile
    plot(y,h0,'Marker','x','Markersize',8);
    hold on
    plot(y,hx,'Marker','o','Markersize',3);
    plot(y,hy,'Marker','o','Markersize',3);
    legend('h_0','h_x','h_y')
    title('Hydrodynamic projections')
    xlabel('y/W');
    ylabel('h_i(y)')

    nexttile
    quiver(para.FSInfo.XY(:,1),para.FSInfo.XY(:,2),para.FSInfo.VFxy(:,1),para.FSInfo.VFxy(:,2));
    xlabel('k_x');
    ylabel('k_y');
    title('FS and v_F')

    nexttile 
    plot(1 : para.SCInfo.itr, para.SCInfo.loss(1 : para.SCInfo.itr),'Marker','o','Markersize',10,'MarkerFaceColor','b');
    xlabel('iterations')
    ylabel('relative loss')
         if ~exist(path,'dir')
             mkdir(path);
         end
         aux_parsavefig(h1,strcat(path,'/results.fig'));
         aux_parsave(strcat(path,'/para.mat'),para);
         close gcf
     end
end
end