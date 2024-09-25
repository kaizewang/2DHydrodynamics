%%
figure;
Vgmc = res1.Vy;
V0 = results.Vy;
dress = results.dress;
diff = zeros(size(dress));
for ii = 1:size(V0,1)
    diff(ii) = max(abs(Vgmc(ii,:))) - max(abs(V0(ii,:)));
end
plot(dress,diff,'-x')
%%
figure;
for ii = 1:size(V0,1)
   plot(res1.rot_angle,Vgmc(ii,:),'-x','DisplayName',...
       ['dress=',num2str(res1.dress(ii),3),' \gamma_{mc}/\gamma_{mr}=1'])
   hold on  
   plot(results.rot_angle,V0(ii,:),'-x','DisplayName',...
       ['dress=',num2str(res1.dress(ii),3),' \gamma_{mc}/\gamma_{mr}=0'])
   legend
   pause()
   hold off
end
%%
figure;
for ii = 1:3
    plot(results.rot_angle,results.Vy(ii,:),'-x',...
        'Displayname',['\gamma_{mr}=',num2str(results.gmr(ii))]);
    hold on;
    legend
    xlabel('misalign angle \phi')
    ylabel('transvers voltage V_y')
    pause()
end