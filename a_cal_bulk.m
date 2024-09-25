function SB = a_cal_bulk(para)
    SB = 0;
    jx = para.src.fth(:,5);
    jy = para.src.fth(:,6);
    A = para.FSInfo.ThAth(:,2);
    h = para.hbulk*para.g/para.gmr;
    th = para.th;
    para.result.Jx = trapz(th.',(A.*jx).'.*h,2);
    para.result.Jy = trapz(th.',(A.*jy).'.*h,2);
    SB = trapz(para.y,para.result.Jx/para.Ex);
  
end