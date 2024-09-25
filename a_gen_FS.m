 function para1 = a_gen_FS(para)
    if para.FSInfo.FSType == "Geo"
        para.IsoVF = 1;
        %para.FSInfo.nRot = 4;
        th0 = pi/(2*para.FSInfo.nRot) + para.FSInfo.th0;
        para.FSInfo.ThR(:,1) = linspace(1e-6,2*pi+1e-6,para.resol).';
        para.FSInfo.ThR(:,2) = 1 + para.FSInfo.dress*sin(para.FSInfo.nRot* ...
            (para.FSInfo.ThR(:,1) + th0));
        [para.FSInfo.XY(:,1),para.FSInfo.XY(:,2)] ...
        = pol2cart( para.FSInfo.ThR(:,1), para.FSInfo.ThR(:,2));
        para.FSInfo.VFxy = aux_gen_VF(para);
%           para.FSInfo.VFxy = ...
%         aux_LineNormals2D(para.FSInfo.XY);
        Tau = zeros(length(para.FSInfo.XY(:,1)),1);
        for ii = 2:length(para.FSInfo.XY(:,1))
             Tau(ii) = aux_arclength(para.FSInfo.XY(1:ii,1),para.FSInfo.XY(1:ii,2));
        end
        para.FSInfo.TauTh(:,1) = Tau;
        para.FSInfo.TauTh(:,2) = para.FSInfo.ThR(:,1);
        para.FSInfo.dThdTau = gradient(para.FSInfo.ThR(:,1))./gradient(Tau);
    elseif para.FSInfo.FSType == "TB"
        
        para.IsoVF = 0;
        para.FSInfo.e_fn = a_gen_TB_model(para);
        rotx = @(k1,k2,t) cos(t)*k1 - sin(t)*k2;
        roty = @(k1,k2,t) cos(t)*k2 + sin(t)*k1;
        syms x y 
        ep_a(x,y) = para.FSInfo.e_fn(x,y);
        vkx = gradient(ep_a,x);
        vky = gradient(ep_a,y);
        para.FSInfo.vkx_fn = matlabFunction(vkx);
        para.FSInfo.vky_fn = matlabFunction(vky);
        
        figure(33);
        fp = fimplicit(para.FSInfo.e_fn,[-pi,pi,-pi,pi],'MeshDensity', para.resol);
        xx = fp.XData.'; yy = fp.YData.';
        xx0 = xx;
        xx(abs(rotx(xx,yy,para.FSInfo.th0))>=pi) = [];
        yy(abs(rotx(xx0,yy,para.FSInfo.th0))>=pi) = [];
        xx0 = xx;
        xx(abs(roty(xx,yy,para.FSInfo.th0))>=pi) = [];
        yy(abs(roty(xx0,yy,para.FSInfo.th0))>=pi) = [];
        xx(isnan(xx)) = [];
        yy(isnan(yy)) = [];
       
        close gcf;
        
        
      
        [kth_pol,kr_pol] = cart2pol(xx,yy);
        [kth_pol,I] = sort(kth_pol);
        kr_pol = kr_pol(I);
        [kth_pol,I] = unique(kth_pol);
        kr_pol = kr_pol(I);
        thq = linspace(-pi+1e-6,pi+1e-6,para.resol).';
        rq = interp1(kth_pol,kr_pol,thq,'spline','extrap');
        kth_pol = thq;
        kr_pol = rq;
        para.FSInfo.ThR(:,1) = kth_pol;
        para.FSInfo.ThR(:,2) = kr_pol;
        [para.FSInfo.XY(:,1),para.FSInfo.XY(:,2)] = pol2cart(kth_pol,kr_pol);
        para.FSInfo.VFxy(:,1) = para.FSInfo.vkx_fn(para.FSInfo.XY(:,1),para.FSInfo.XY(:,2));
        para.FSInfo.VFxy(:,2) = para.FSInfo.vky_fn(para.FSInfo.XY(:,1),para.FSInfo.XY(:,2));
        Tau = zeros(length(para.FSInfo.XY(:,1)),1);
        for ii = 2:length(para.FSInfo.XY(:,1))
             Tau(ii) = aux_arclength(para.FSInfo.XY(1:ii,1),para.FSInfo.XY(1:ii,2));
        end
        para.FSInfo.TauTh(:,1) = Tau;
        para.FSInfo.TauTh(:,2) = para.FSInfo.ThR(:,1);
        para.FSInfo.dThdTau = gradient(para.FSInfo.ThR(:,1))./gradient(Tau);
        para.FSInfo.e_fn  = [];
        para.FSInfo.vkx_fn = [];
        para.FSInfo.vky_fn = [];
    end
    para.FSInfo.ThAth(:,2) = (para.FSInfo.XY(:,1).^2 + para.FSInfo.XY(:,2).^2)./...
       (para.FSInfo.VFxy(:,1).* para.FSInfo.XY(:,1)+...
        para.FSInfo.VFxy(:,2).*para.FSInfo.XY(:,2));
    para.FSInfo.ThAth(:,1) = para.FSInfo.ThR(:,1);
    para.FSInfo.TauAtau(:,2) = abs(para.FSInfo.dThdTau).*sqrt(para.FSInfo.XY(:,1).^2 + para.FSInfo.XY(:,2).^2)./...
        sqrt(para.FSInfo.VFxy(:,1).^2 + para.FSInfo.VFxy(:,2).^2);
    para.FSInfo.TauAtau(:,1) = para.FSInfo.TauTh(:,1);
    %generate the B-field derivative term 
    norm_vecx = para.FSInfo.VFxy(:,1)./(sqrt(para.FSInfo.VFxy(:,1).^2 + para.FSInfo.VFxy(:,2).^2));
    norm_vecy = para.FSInfo.VFxy(:,2)./(sqrt(para.FSInfo.VFxy(:,1).^2 + para.FSInfo.VFxy(:,2).^2));
    para.FSInfo.TauTh(:,3) = -norm_vecy;
    para.FSInfo.TauTh(:,4) = norm_vecx;
    para.FSInfo.TauTh_order = "tau-theta-taux-tauy";
    htau = sqrt((gradient(para.FSInfo.ThR(:,2))./gradient(para.FSInfo.TauTh(:,1))).^2 ...
        + (para.FSInfo.ThR(:,2).*para.FSInfo.dThdTau).^2);
    para.Bdel = 1 ./ htau.*para.FSInfo.dThdTau.*...
        (-para.FSInfo.VFxy(:,1).*para.FSInfo.TauTh(:,4) + para.FSInfo.VFxy(:,2).*para.FSInfo.TauTh(:,3));
    para.FSInfo.BCf = zeros(size(para.FSInfo.VFxy(:,2)));
    para1 = para;
end