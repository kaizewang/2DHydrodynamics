%cd 'D:\dropbox_files\Dropbox\hydro\project_BTE\workspace\2D_Kaize_codes\v2\'
para = a_para_init('Ny',40,'Nth',40,'aa',0.1);
para.hOld = para.hinit;
para.hNew = para.hinit;
para = a_cal_source(para);
para = a_sc_loop(para);
a_writehis(para);
%cd(para.SavingRootPath)