%-----my calculation-----------
para = a_para_init();
para = a_h_init(para);
para.hOld = para.hinit;
para.hNew = para.hinit;
para = a_cal_source(para);





%analytic solution
t = para.FSInfo.t1;
mu = para.FSInfo.mu;
kF = sqrt(4 + mu/t);
vF = 2*t*kF;
hf = @(y,th) para.Ex/para.gmr.*vF*cos(th).*(1-  ...
    exp(-para.gmr*(1 + 2.*y.*sign(th))./(2*vF.*sin(abs(th)))) );
th = para.th;
y = para.y;
[yy,tth] = meshgrid(y,th);
h_ana = hf(yy,tth);
h_ana = h_ana';
h0 = trapz(para.th,cos(0*para.th).'/pi.*h_ana,2);
h2 = trapz(para.th,cos(2*para.th).'/pi.*h_ana,2);
Ey = gradient(1/2*h2 - h0)./gradient(y);

figure
imagesc(th,y,para.hNew ./ h_ana - 1 )
cmap(para.hNew ./h_ana -1 )
colorbar







