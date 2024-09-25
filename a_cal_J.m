function para1 = a_cal_J(para)
    jx = para.src.fth(:,5);
    jy = para.src.fth(:,6);
    A = para.FSInfo.ThAth(:,2);
    h = para.hNew;
    th = para.th;
    para.result.Jx = trapz(th.',(A.*jx).'.*h,2);
    para.result.Jy = trapz(th.',(A.*jy).'.*h,2);
    para.result.Sxx = trapz(para.y,para.result.Jx/para.Ex);
    para1 = para;
end