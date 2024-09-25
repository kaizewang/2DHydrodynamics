function para1 = a_para_renew(para,varargin)
    th0 = para.FSInfo.th0;
    B0 = para.B;
    gmc0 = para.gmc;
    gmr0 = para.gmr;
    if para.FSInfo.FSType == "Geo"
        aa0 = para.FSInfo.dress;
    else
        mu0 = para.FSInfo.mu;
    end
    P = inputParser;
    addParameter(P,'B',B0);
    addParameter(P,'gmc',gmc0);
    addParameter(P,'gmr',gmr0);
    if para.FSInfo.FSType == "Geo"
        addParameter(P,'aa',aa0);
         
    else
        addParameter(P,'mu',mu0);
        
    end
    
    addParameter(P,'FSrot_angle',th0);
    parse(P,varargin{:});
    para.B = P.Results.B;
    para.gmc = P.Results.gmc;
    para.gmr = P.Results.gmr;
    para.g = para.gmc + para.gmr;
    para.FSInfo.th0 = P.Results.FSrot_angle;
    if para.FSInfo.FSType == "Geo"
         para.FSInfo.dress = P.Results.aa;
    else
         para.FSInfo.mu = P.Results.mu;
    end    
    %---renew FS Info--------
    para = a_gen_FS(para);
    %---Initial guess--------
    para = a_h_init(para);
    %---renew SC status--------
    para.SCInfo.Flag = 1;
    para.SCInfo.itr = 0;
    para.SCInfo.Status = "Normal";
    para.SCInfo.loss =  -ones(para.SCInfo.Maxitr,1);
    para.SCInfo.tstat = -ones(para.SCInfo.Maxitr,1);
    %renew data storage info
    root_path = '../../../data/TwoD_DATA_V10/';
    %time = para.time;
    para = a_para_saving_path2(para,root_path);
    para1 = para;
end