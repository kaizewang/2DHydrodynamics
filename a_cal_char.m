function para1 = a_cal_char(para)
    vy = para.FSInfo.VFxy(:,2);
    %vx = para.FSInfo.VFxy(:,1);
    %h = para.hOld;
    S = para.src.S;
    y = para.y;
    th = para.th;
    [yg,thg] = ndgrid(y,th);
    %vxpp = griddedInterpolant(th,vx,"spline", ...
       % "spline");
    vypp = griddedInterpolant(th,vy,"spline", ...
        "spline");
    Syth_pp = griddedInterpolant(yg,thg,S,"spline","spline");
    %hyth_pp = griddedInterpolant(yg,thg,h,"spline","spline");
    para.clines.thf = @(xi,s) xi*ones(size(s));
    para.clines.yf = @(xi,s) s.*(vypp(para.clines.thf(xi,s))) - ...
    sign(vypp(para.clines.thf(xi,s)))/2;
    para.clines.xif = @(yy,tth) tth;
    para.clines.sf = @(yy,tth) (yy + sign(vypp(tth))/2)./(vypp(tth));
    xig = para.clines.xif(yg,thg); 
    sg = para.clines.sf(yg,thg);
    %Ssxi_pp = scatteredInterpolant(sg(:),xig(:),S(:),"natural","nearest");
    hbc = para.FSInfo.BCf;
    hbcxi_pp = griddedInterpolant(th,hbc,"spline","spline");
    hsxi_new = zeros(size(xig));
    for ii = 1:size(xig,1)
        for jj = 1:size(xig,2)
            %sp = linspace(0,sg(ii,jj),3e2).';
            %xi_temp = xig(ii,jj)*ones(size(sp));
            ftemp = @(sp) exp(-para.g*(sg(ii,jj) - sp)).*...
                (Syth_pp(para.clines.yf(xig(ii,jj),sp).',para.clines.thf(xig(ii,jj),sp).').');
            Itemp = integral(@(sp)ftemp(sp),0,sg(ii,jj));
%             hsxi_new(ii,jj) = trapz(sp,exp(-para.g*(sg(ii,jj) - sp)).*Syth_pp(para.clines.yf(xi_temp,sp),para.clines.thf(xi_temp,sp)))...
%                 + hbcxi_pp(xig(ii,jj)) * exp(-para.g*sg(ii,jj));
            hsxi_new(ii,jj) = Itemp + hbcxi_pp(xig(ii,jj)) * exp(-para.g*sg(ii,jj));
%             if abs(sg(ii,jj))> 5e2
%                 disp("!");
%             end
        end
    end
    para.hNew = hsxi_new;
    para1 = para;
end