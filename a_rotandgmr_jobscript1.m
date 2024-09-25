time = datestr(now,'mmdd-HH-MM-SS');
dress_array = 0.343;
rot_angle = linspace(0,pi/4,20).';
gmr_array = linspace(0.5,20,10);
gmc = 0;
Phiy  = zeros(length(gmr_array),length(rot_angle));
results = [];
results.gmr = gmr_array;
results.gmc = gmc;
results.dress = dress_array;
results.rot_angle = rot_angle;
results.Vy = Phiy;
for kk = 1:length(gmr_array)
    for ii = 1:length(dress_array)
        for jj = 1:length(rot_angle)
            iitr = (kk - 1) * length(rot_angle) + jj;
            disp(['finishing percentage:',num2str(iitr/length(rot_angle)...
                /length(gmr_array)*100,3),'%']);
            if jj == 1 && kk==1
                para = a_para_init('aa',dress_array(ii),'gmr',gmr_array(kk),...
                    'gmc',gmc,'Ny',100,'Nth',100,'FSrot_angle',rot_angle(1),'jobdis','gmrjobs343Test',...
                    'TS',time);
            else
                para = a_para_renew(para,'FSrot_angle',rot_angle(jj),'gmr',gmr_array(kk));
            end
            para = a_cal_source(para);
            para = a_sc_loop(para);
            a_writehis(para);
            if mod(kk,2) == 0
                Phiy(kk,end + 1 -jj) = trapz(para.y,para.src.Ey);
            else
                Phiy(kk,jj) = trapz(para.y,para.src.Ey);
            end
            results.Vy = Phiy;
            save([para.Xfile_name2,'/results.mat'],"results","-v7.3");
        end
        rot_angle = rot_angle(end:-1:1);
    end
end

