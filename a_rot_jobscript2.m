%%
% this is a test of rotation and see the change of Ey
% different gmr influence
rot_angle = linspace(0,pi,40).';
gmc_array = [0;0.1;0.5;1;2];
iitr = 0;
Phiy = zeros(length(gmc_array),length(rot_angle));
res = [];
for jj = 1:length(gmc_array)
    for ii = 1:length(rot_angle)
        iitr = iitr + 1;
       % clc;
        disp(['finishing percentage:',num2str(iitr/length(rot_angle)/length(gmc_array)*100,3),'%']);
        if jj == 1 && ii == 1
            para = a_para_init('aa',0.15,'gmr',0.1,'gmc',gmc_array(jj),'Ny',100,'Nth',100,'FSrot_angle',rot_angle(ii),'jobdis','C4rot');
        else
             para = a_para_renew(para,'aa',0.15,'gmr',0.1,'gmc',gmc_array(jj),'FSrot_angle',rot_angle(ii));
        end
         para.SavingRootPath = ['../../../TwoD_DATA_V4/',para.time,'-',para.jobdis,'/gmc-',num2str(para.gmc),'-gmr-',num2str(para.gmr),...
        '-B-',num2str(para.B),'-rot-',num2str(para.FSInfo.th0/pi*180),'deg'];
        para.hOld = para.hinit;
        para.hNew = para.hinit;
        para = a_cal_source(para);
        para = a_sc_loop(para);
        a_writehis(para);
        Phiy(jj,ii) = trapz(para.y,para.src.Ey);
        res.ra = rot_angle;
        res.gmc = gmc_array;
        res.Vy = Phiy;
        save(['../../../TwoD_DATA_V4/',para.time,'-',para.jobdis,'/res.mat'],"res");
    end
end