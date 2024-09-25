function a_writehis(para)
    StartTime = {para.time};
    Gmc = para.gmc;
    Gmr = para.gmr;
    B = para.B;
    LossEnd = para.SCInfo.loss(end);
    ExitStatus = {para.SCInfo.Status};
    Runtime = sum(para.SCInfo.tstat(para.SCInfo.tstat>0),'all');
    FileLoc = {para.SavingRootPath};
    if para.FSInfo.FSType == "Geo"
        FSType = {strcat('dress',num2str(para.FSInfo.dress),num2str(para.FSInfo.nRot),' fold-',para.FSInfo.FSType)};
    else
        FSType = {para.FSInfo.FSType};
    end

    T = table(StartTime,Gmc,Gmr,B, FSType, LossEnd,ExitStatus,Runtime, FileLoc);
    writetable(T, para.Xfile_name1,'Sheet',1,'WriteRowNames',0,'WriteMode','append')
end