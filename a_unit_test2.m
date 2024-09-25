%this is a test of increasing Ny and see the change of Ey

Ny_array1 = 1e2;
Nth_array1 = (1:1:10)*100;
%Nth_array1 = (30:10:100)';
iitr = 0;
para_set_conv_study = cell(length(Ny_array1),length(Nth_array1));
for ii = 1:length(Ny_array1)
    iitr = iitr + 1;
    aux_progress(iitr,length(Ny_array1)*length(Nth_array1),'*');
    for jj = 1:length(Nth_array1)
         para = a_para_init('aa',0.15,'gmr',1,'gmc',0,'Ny',Ny_array1(ii),'Nth',Nth_array1(jj),'FSrot_angle',pi/3);
         para.hOld = para.hinit;
         para.hNew = para.hinit;
         para = a_cal_source(para);
         para = a_sc_loop(para);
         para_set_conv_study{ii,jj} = para;
    end
end

%%
% this is a test of rotation and see the change of Ey
rot_angle = linspace(0,pi,40).';
para_set_rot_study = cell(length(rot_angle),1);
iitr = 0;
Phiy = [];
for ii = 1:length(rot_angle)
    iitr = iitr + 1;
    aux_progress(iitr,length(rot_angle),'*');
    para = a_para_init('aa',0.15,'gmr',1,'gmc',0,'Ny',100,'Nth',600,'FSrot_angle',rot_angle(ii));
    para.hOld = para.hinit;
    para.hNew = para.hinit;
    para = a_cal_source(para);
    para = a_sc_loop(para);
    para_set_rot_study{ii,1} = para;
    Phiy = [Phiy;trapz(para.y,para.src.Ey)];
end