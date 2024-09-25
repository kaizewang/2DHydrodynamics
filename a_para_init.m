function para = a_para_init(varargin)
    P = inputParser;
    addParameter(P,'B',0);
    addParameter(P,'gmc',0);
    addParameter(P,'gmr',1);
    addParameter(P,'aa',0);%dress
    addParameter(P,'Mitr',150);
    addParameter(P,'Nth',1e2);
    addParameter(P,'Ny',1e2);
    addParameter(P,'lrate',0.5);
    addParameter(P,'FSrot_angle',0);
    addParameter(P,'jobdis','test');
    addParameter(P,'TS',datestr(now,'mmdd-HH-MM-SS'));
    addParameter(P,'mu',0);
    addParameter(P,'TBmodel',"Simple");
    addParameter(P,'FSType',"Geo");
    addParameter(P,'FSnRot',4);
    addParameter(P,'save',1);
    parse(P,varargin{:});
    para.B = P.Results.B;
    para.save = P.Results.save;
    para.gmc = P.Results.gmc;
    para.gmr = P.Results.gmr;
    para.Ny = P.Results.Ny;
    para.resol = P.Results.Nth;
    para.src.Ey = zeros(para.Ny,1);
    para.SCInfo.Maxitr = P.Results.Mitr;
    para.SCInfo.lrate = P.Results.lrate;
    para.FSInfo.th0 = P.Results.FSrot_angle;
    para.time = P.Results.TS;
    %---system para
    para.Ex = 1;
    para.g = para.gmc + para.gmr;
    %---FS info-----------------------
    para.FSInfo.FSType = P.Results.FSType;
    if  para.FSInfo.FSType == "Geo"
        para.FSInfo.nRot = P.Results.FSnRot;
        para.FSInfo.dress = P.Results.aa;
    else
        para.FSInfo.TBmodel = P.Results.TBmodel;
        para.FSInfo.mu = P.Results.mu;
    end
    para = a_gen_FS(para);
    para.Nth = length(para.FSInfo.ThR(:,1));
    %---Initial guess--------
    para = a_h_init(para);
    para.hNew = para.hinit;
    para.hOld = para.hinit;
    %---self consis---------
    para.SCInfo.trackitr = 0;
    para.SCInfo.itr = 0;
    para.SCInfo.tol = 1e-3;
    para.SCInfo.tstat = -ones(para.SCInfo.Maxitr,1);
    para.SCInfo.Flag = 1;
    para.SCInfo.Status = "Normal";
    para.SCInfo.loss =  -ones(para.SCInfo.Maxitr,1);
    para.SCInfo.saving_steps = 1;
    %---data saving-------
    root_path = '../../../data/TwoD_DATA_V10/';
    %time = para.time;
    para.jobdis = strcat(P.Results.jobdis,'-',para.FSInfo.FSType);
    if  para.FSInfo.FSType == "Geo"
        para.jobdis = strcat(para.jobdis,'-dress-',num2str(1000*para.FSInfo.dress,3));
    else
        para.jobdis = strcat(para.jobdis,'-mu-',num2str(para.FSInfo.mu,3));
    end
    if para.save
        para = a_para_saving_path2(para,root_path);
    end
end






