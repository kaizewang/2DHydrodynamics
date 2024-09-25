function para1 = a_para_saving_path1(para,oB,ophi)
    arguments
        para ; 
        oB = 0;
%         ogmc = 1;
%         ogmr = 1;
        ophi = 1;
    end
    core_path = ['../../../TwoD_DATA_V51/',para.time,'-',para.jobdis,...
        '/gmc-', num2str(para.gmc),'-gmr-', num2str(para.gmr),...
        '-mu-',num2str(para.FSInfo.mu,3),'/'];
    save_path = core_path;
    if ophi
        save_path = [save_path,'-rot-',num2str(para.FSInfo.th0/pi*180,3),'deg'];
    end
    if oB 
        save_path = [save_path,'-B-',num2str(para.B)];
    end
%     if ogmc
%         save_path = [save_path,'-gmc-', num2str(para.gmc)];
%     end
%     if ogmr 
%         save_path = [save_path,'-gmr-', num2str(para.gmr)];
%     end
   
    para.SavingRootPath = save_path;
    mkdir(para.SavingRootPath);
    para.Xfile_name1 = ['../../../TwoD_DATA_V5/',para.time,'-',para.jobdis,'/calhis.xlsx'];
    para.Xfile_name2 = ['../../../TwoD_DATA_V5/',para.time,'-',para.jobdis];
    para1 = para;
end