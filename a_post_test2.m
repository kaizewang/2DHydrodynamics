figure(11)
figure(12)
for ii = 1:size(para_set_conv_study,1)
     for jj = 1:size(para_set_conv_study,2)
        para = para_set_conv_study{ii,jj};
        figure(11)
        plot(para.y,para.src.Ey,'-x','DisplayName',['Ny=',num2str(para.Ny),',Nth=',num2str(para.Nth)]);
        hold on
        legend
        pause()
        figure(12)
        plot(para.y,para.result.Jx,'-x','DisplayName',['Ny=',num2str(para.Ny),',Nth=',num2str(para.Nth)]);
        hold on
        pause()
        legend
     end
end

%%
figure(13)
tt = [];
Phiy = [];
for ii = 1:length(para_set_rot_study)
    para = para_set_rot_study{ii};
    tt = [tt;para.FSInfo.th0];
    Phiy = [Phiy;trapz(para.y,para.src.Ey)];
end
plot(tt,Phiy,'-o')

%%
figure(16)
for ii = 1:length(Ny_array1)
     for jj = 1:length(Nth_array1)
        para = para_set_conv_study{ii,jj};
        plot(para.y,para.hNew(:,end/2))
        hold on
        pause()
     end
end

%cmap(Eyy)
%colorbar


%%
figure(15)
for ii = 1:length(Ny_array1)
     for jj = 1:length(Nth_array1)
        para = para_set_conv_study{ii,jj};
        surf(para.th,para.y,para.hNew)
        hold on
        pause()
     end
end
%%
figure(16)
kk = 0;
for ii = 1:length(Ny_array1)
     for jj = 1:length(Nth_array1)
         kk = kk +1;
        para = para_set_conv_study{ii,jj};
        [yg,thg] = ndgrid(para.y,para.th);
        F = griddedInterpolant(yg,thg,para.hNew);
        yq = para_set_conv_study{end}.y;
        thq = para_set_conv_study{end}.th;
        [yqg,thqg] = ndgrid(yq,thq);
        hq = F(yqg,thqg);
        hh(:,:,kk) = hq;
     end
end