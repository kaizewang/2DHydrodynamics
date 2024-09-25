time = datestr(now,'mmdd-HH-MM-SS');
dress_array = linspace(0,0.8,5).';
rot_angle = linspace(0,pi/4,25).';
gmr = 0.1;
gmc = 0;
Phiy  = zeros(length(dress_array),length(rot_angle));
results = [];
results.gmr = gmr;
results.gmc = gmc ;
results.dress = dress_array;
results.rot_angle = rot_angle;
results.Vy = Phiy;
for ii = 1:length(dress_array)
    for jj = 1:length(rot_angle)
         iitr = (ii - 1) * length(rot_angle) + jj;
         disp(['finishing percentage:',num2str(iitr/length(rot_angle)...
             /length(dress_array)*100,3),'%']);
        if jj == 1
           para = a_para_init('aa',dress_array(ii),'gmr',gmr,...
               'gmc',gmc,'Ny',100,'Nth',300,'FSrot_angle',rot_angle(1),'jobdis','C4rotTest',...
               'TS',time);
        else
            para = a_para_renew(para,'FSrot_angle',rot_angle(jj));
        end    
        para = a_cal_source(para);
        para = a_sc_loop(para);
        a_writehis(para);
        Phiy(ii,jj) = trapz(para.y,para.src.Ey);
        results.Vy = Phiy;
        save([para.Xfile_name2,'/results.mat'],"results","-v7.3");
    end
end


