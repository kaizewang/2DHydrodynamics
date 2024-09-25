function a_result_saving(para)
    path = strcat(para.SavingRootPath,'/-itr-',num2str(para.SCInfo.itr));
    para.clines = [];
    a_post_process(para,1,path);
    %a_post_process(para);
end