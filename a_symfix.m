function para = a_symfix(para)
    h = para.hNew;
    y = para.y;
    para1 = para;
    for ii = 1:length(y)/2
        h(ii,:) = (h(ii,:) + h(end-ii+1,end:-1:1))/2;
        h(end-ii+1,:) = h(ii,end:-1:1);
    end
    para1.hNew = h;
    para1.hOld = h;
    para1 = a_cal_source(para1);
    para1 = a_cal_J(para1);
    para = para1;
end








