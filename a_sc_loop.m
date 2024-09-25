function para1 = a_sc_loop(para)
    while(para.SCInfo.Flag)
        para.SCInfo.itr = para.SCInfo.itr + 1;
        itr = para.SCInfo.itr;
        %disp(['itr=',num2str(itr)]);
        if itr == para.SCInfo.Maxitr
            para.SCInfo.Flag = 0;
            para.SCInfo.Status = "Forced exit";
        end
        tic
        para = a_cal_char(para);
        h1 = para.hNew;
        para = a_jy_proj(para);
        los1 = sum(abs(para.src.EyOld - para.src.Ey)./abs(para.src.EyOld),'all')/length(para.src.Ey);
        los2 = max(abs(para.src.EyOld - para.src.Ey)./0.05,[],'all')/length(para.src.Ey);
        los3 = max(abs(para.hNew-para.hOld)./0.1,[],'all');
        los4 = sum(abs(para.hNew-para.hOld)./abs(para.hNew),'all')/length(para.hNew(:));
        loss_rel = los1 + los4;
        loss_abs = los2 + los3;
        loss = min(loss_abs,loss_rel);
        para.SCInfo.loss(itr) = loss;
        para.err =  sum(abs(para.hNew-h1)./abs(para.hNew),'all')/length(para.hNew(:));
        if para.SCInfo.loss(itr)<para.SCInfo.tol
            para.SCInfo.Flag = 0;
        else
            para.hOld = para.hOld*para.SCInfo.lrate + para.hNew*(1-para.SCInfo.lrate);
        end
        para = a_cal_source(para);
        para = a_cal_J(para);
        if ~mod(itr,para.SCInfo.saving_steps)|| (para.SCInfo.Flag == 0)
            a_result_saving(para);
        end
        para.SCInfo.tstat(itr) = toc;
    end
    para.SCInfo.tstat(para.SCInfo.tstat<0) = [];
    para.SCInfo.loss(para.SCInfo.loss<0) = [];
    para1 = para;
end