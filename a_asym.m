vfa = mean(sqrt(w.FSInfo.VFxy(:,1).^2 + w.FSInfo.VFxy(:,2).^2));
Vss = [];V1=[];V2=[];
for ii = 1:(size(Vq,1))
    Vqq = Vq(ii,:);
    Va = Vqq - Vqq(end:-1:1);Va = Va/2;
    Vs = Vqq + Vqq(end:-1:1);Vs = Vs/2;
    figure(59)
    plot(rad2deg(rot_angle),Va,'DisplayName',['\gamma_{{mc}}W/v_F=',num2str(gmc_array(ii)/vfa,3)]);
    hold on
    recolor
    %legend
    figure(60)
     plot(rad2deg(rot_angle),Vs,'DisplayName',['\gamma_{{mc}}W/v_F=',num2str(gmc_array(ii)/vfa,3)]);
     hold on
     recolor
    Vss(ii) = Va(3);
    V1(ii) = Vqq(3);
    V2(ii) = Vqq(8);
end
%   figure(60)
%     scatter(gmc_array(1:(size(Vq,1))),Vss,100,'filled','blue');
%     hold on
%     plot(gmc_array(1:(size(Vq,1))),Vss,'b')
%     figure(61)
%     scatter(gmc_array(1:(size(Vq,1))),V1,100,'filled','red');
%      hold on
%     plot(gmc_array(1:(size(Vq,1))),V1,'red')
%    
%      scatter(gmc_array(1:(size(Vq,1))),V2,100,'filled','black');
%       plot(gmc_array(1:(size(Vq,1))),V2,'black')