function para1 = a_h_init(para)
    Ny = para.Ny; Ex = para.Ex; g = para.gmc + para.gmr;
    y = linspace(-1/2,1/2,Ny).';
    th = para.FSInfo.ThR(:,1);
    vx = para.FSInfo.VFxy(:,1);
    vy = para.FSInfo.VFxy(:,2);
    h = zeros(Ny,length(th));
    for ii = 1:Ny
        h(ii,:) = Ex./g.*vx.*(1 - exp(-g./abs(2*vy).*(2*sign(vy)*y(ii)+1)));
        h1(ii,:) = Ex./g.*vx;
    end
    para.hinit = h;
    para.hbulk = h1;
    para.y = y;
    para.th = th;
    para1 = para;
end