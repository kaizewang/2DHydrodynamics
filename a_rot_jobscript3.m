%%
% this is a test of rotation and see the change of Ey
% different gmr influence
rot_angle = linspace(0,pi/4,15).';
dress_array = linspace(0,0.8,10);
iitr = 0;
Phiy = zeros(length(dress_array),length(rot_angle));
res = [];
for jj = 1:length(dress_array)
    for ii = 1:length(rot_angle)
        iitr = iitr + 1;
       % clc;
        disp(['finishing percentage:',num2str(iitr/length(rot_angle)/length(dress_array)*100,3),'%']);
        if jj == 1 && ii == 1
            para = a_para_init('aa',dress_array(jj),'gmr',0.1,'gmc',2,'Ny',100,'Nth',100,'FSrot_angle',rot_angle(ii),'jobdis','C4rot');
        else
             para = a_para_renew(para,'aa',dress_array(jj),'gmr',0.1,'gmc',2,'FSrot_angle',rot_angle(ii));
        end
         para.SavingRootPath = ['../../../TwoD_DATA_V42/',para.time,'-',para.jobdis,'/gmc-',num2str(para.gmc),'-gmr-',num2str(para.gmr),...
        '-B-',num2str(para.B),'-rot-',num2str(para.FSInfo.th0/pi*180),'deg',...
        '-dress-',num2str(dress_array(jj))];
        para.hOld = para.hinit;
        para.hNew = para.hinit;
        para = a_cal_source(para);
        para = a_sc_loop(para);
        a_writehis(para);
        Phiy(jj,ii) = trapz(para.y,para.src.Ey);
        res.ra = rot_angle;
        res.dress = dress_array;
        res.gmc = 2;
        res.gmr = 0.1;
        res.Vy = Phiy;
        save(['../../../TwoD_DATA_V42/',para.time,'-',para.jobdis,'/res.mat'],"res");
    end
end