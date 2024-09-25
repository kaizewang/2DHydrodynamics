function para1 = a_para_saving_path2(para,root_path,oB,ophi)
    %root_path = '../../../TwoD_DATA_V7/';
    arguments
        para ; 
        root_path ;
        oB = 0;
        ophi = 1;
    end
    if para.FSInfo.FSType == "Geo"
        core_path = strcat(root_path,para.time,'-',para.jobdis,...
        '/gmc-', num2str(para.gmc),'-gmr-', num2str(para.gmr),...
        '-dress-',num2str(para.FSInfo.dress,3),'/');
    else
         core_path = strcat(root_path,para.time,'-',para.jobdis,...
        '/gmc-', num2str(para.gmc),'-gmr-', num2str(para.gmr),...
        '-mu-',num2str(para.FSInfo.mu,3),'/');
    end
    save_path = core_path;
    if ophi
        save_path = strcat(save_path,'-rot-',num2str(para.FSInfo.th0/pi*180,3),'deg');
    end
    if oB 
        save_path = strcat(save_path,'-B-',num2str(para.B));
    end
%     if ogmc
%         save_path = [save_path,'-gmc-', num2str(para.gmc)];
%     end
%     if ogmr 
%         save_path = [save_path,'-gmr-', num2str(para.gmr)];
%     end
   
    para.SavingRootPath = save_path;
    mkdir(para.SavingRootPath);
    para.Xfile_name1 = strcat(root_path,para.time,'-',para.jobdis,'/calhis.xlsx');
    para.Xfile_name2 = strcat(root_path,para.time,'-',para.jobdis);
    para1 = para;
end