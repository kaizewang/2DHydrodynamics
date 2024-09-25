%%
%rootdir = 'C:/Users/wangk/ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de/Projects/project_BTE/TwoD_DATA_V7/0108-22-18-16-gmcjobs343';
%mode = 1, plot h
%mode = 2, plot Phiy
%mode = 3, plot Phiy diff
%mode = 4, plot h diff
mode = 3;
disp = 0;
save = 0;

%rootdir = 'C:/Users/wangk/ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de/Projects/project_BTE/TwoD_DATA_V7/0108-22-18-16-gmcjobs343';
%rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0111-01-26-29-gmcjobsTB-hex-mu-0';
rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0111-16-32-48-gmcjobsTB-simple-mu--0.1';
% rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0112-15-12-50-gmcjobsTB-Bi2212-TB-mu--0.9';
%rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0112-19-06-59-gmcjobsTBTest-TB-mu--0.1';
%rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0114-13-09-59-gmcjobsTB-PdCoO2-TB-mu-0';
%rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0115-16-04-39-gmcjobsTB-PdCoO2-TB-0';
%rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0116-18-04-01-gmcjobsCont-cross-TB-mu-0';
%rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0111-01-26-29-gmcjobsTB-hex-mu-0';
%rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0114-23-08-51-C6gmcjobs300-Geo-dress-600';
%rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\TwoD_DATA_V8\0114-23-08-51-C6gmcjobs300-Geo-dress-300';
% rootdir = 'C:\Users\wangk\ownCloud - kaize.wang@mpsd.mpg.de@owncloud.gwdg.de\Projects\project_BTE\data\TwoD_DATA_V10\0217-01-20-34-gmcjobsCont-cross-TB-mu-0';
q = dir([rootdir '/gmc*']);
q = {q.name}; q=q((q~=".") & (q~=".."));
q = natsort(q);
s = shiftdim(string(q));
ss = split(s,'-');
rnds = unique(ss(:,1));
result = load([rootdir,'/results.mat']);
nn = fieldnames(result);
result = eval(['result.',nn{1}]);
rot_angle = result.rot_angle;
gmc_array = result.gmc;
qsub = dir([rootdir '/' q{1} '/*']);
qsub = {qsub.name}; qsub=qsub((qsub~=".") & (qsub~=".."));
qsub = natsort(qsub);
ssub = shiftdim(string(qsub));
sssub = split(ssub,'-');
rndssub = unique(sssub(:,1));

dats = cell(length(qsub),length(q));
Vq = zeros(length(qsub),length(q));
Sxxq = Vq;
Vstress = Vq;
VB = Vq;
Vcol = Vq;
Vgmc1 = Vq;
Vgmc2 = Vq;
Vvp = Vq;
Eys = [];
for ii = 1:length(qsub)%rot loop
    if disp
        figure(ii);
    end
    for jj = 1:length(q)
        %figure
        qqq = dir([rootdir '/' q{jj} '/' qsub{ii}]);
        qqq = {qqq.name}; qqq=qqq((qqq~=".") & (qqq~=".."));
        if isempty(qqq)
            continue
        end
        dats{ii,jj} = [rootdir '/' q{jj} '/' qsub{ii} '/' qqq{1} '/para.mat' ];
        w = load(dats{ii,jj});
        ppp = fieldnames(w);
        if ppp{1}== 'para'
            w = w.para;
        else
            w = w.x;
        end
        rot = w.FSInfo.th0;
%         if rad2deg(rot) == 0 || rad2deg(rot) == 45
%             w = a_symfix(w);
%             a_result_saving(w);
%         end
        gmc = w.gmc;
        h = w.hNew;
        t = w.FSInfo.ThR(:,1); r = w.FSInfo.ThR(:,2); A = w.FSInfo.ThAth(:,2);
        vx = w.FSInfo.VFxy(:,1); vy = w.FSInfo.VFxy(:,2);
        Yx = w.src.fth(:,3);
        Yy = w.src.fth(:,4);
        jy = w.src.fth(:,6);
        [hdth,hdy] = gradient(h,w.th,w.y);
        helper1 = (A.*jy.^2).'.*hdy;
        helper2 = w.B*(A.*w.Bdel.*jy).'.*hdth;
        helper3 = w.g*(A.*jy).'.*h;
        %helper4 = (A.*jy.*py).'.*hdy;
        hx =(A.*Yx).'.*h;
        hy = (A.*Yy).'.*h;
        temp1 = trapz(w.th,A.*jy.*Yx);
        temp2 = trapz(w.th,A.*jy.*Yy);
        temp3 = trapz(w.th,A.*jy.^2);
        Ey = (helper1 + helper2 + helper3 - ...
            w.gmc .* hx .* temp1 - w.gmc .* hy .* temp2)./temp3;
        Eys(ii,jj,:) = trapz(w.th,Ey,2);
        Phiy = trapz(w.y,Ey,1);
        P1 = trapz(w.y,helper1./temp3,1);
        P2 = trapz(w.y,helper2./temp3,1);
        P3 = trapz(w.y,helper3./temp3,1);
        P4 = trapz(w.y, w.gmc .* hx .* temp1./temp3,1);
        P5 = trapz(w.y, w.gmc .* hy .* temp2./temp3,1);
        Vq(ii,jj) = (trapz(w.th,Phiy));
        Sxxq(ii,jj) = w.result.Sxx;
        Vstress(ii,jj) = trapz(w.th,P1);
        VB(ii,jj) = trapz(w.th,P2);
        Vcol(ii,jj) = trapz(w.th,P3);
        Vgmc1(ii,jj) = trapz(w.th, P4);
        Vgmc2(ii,jj) = trapz(w.th, P5);
        


        if disp
            plot(w.FSInfo.XY(:,1),w.FSInfo.XY(:,2),'LineWidth',2,'DisplayName',['\gamma_{mc}=',num2str(w.gmc)]);
            title(['rot=',num2str(rot/pi*180),'deg']);
            hold on
            plot([0,1*cos(-w.FSInfo.th0)],[0,1*sin(-w.FSInfo.th0)],'LineWidth',3,'LineStyle','--');
            if mode == 1
                scatter(w.FSInfo.XY(:,1),w.FSInfo.XY(:,2),100,w.hNew(end/2,:),'filled');

                if jj == 1
                    cmap(1.2*h(end/2,:));
                    cc = 1.2*h(end/2,:);
                end
                dir_name = [rootdir,'/hfigs/'];
                file_name = [rootdir,'/hfigs/',['rot=',num2str(rot/pi*180),'deg.gif']];
            elseif mode == 2
                scatter(w.FSInfo.XY(:,1),w.FSInfo.XY(:,2),100,Phiy,'filled');
                if jj == 1
                    cmap(1.5*Phiy);
                    cc = 1.5*Phiy;
                end

                dir_name = [rootdir,'/Phiyfigs/'];
                file_name = [rootdir,'/Phiyfigs/',['rot=',num2str(rot/pi*180),'deg.gif']];
            elseif mode ==3
                pd = a_pi_add(w.th,Phiy);
                scatter(w.FSInfo.XY(:,1),w.FSInfo.XY(:,2),100,pd,'filled');
                if jj == 1
                    cmap(1.5*pd);
                    cc = 1.5*pd;
                end

                dir_name = [rootdir,'/Phiy_pi_figs/'];
                file_name = [rootdir,'/Phiy_pi_figs/',['rot=',num2str(rot/pi*180),'deg.gif']];
            elseif mode == 4
                pd = a_pi_add(w.th,h(end/2,:));
                scatter(w.FSInfo.XY(:,1),w.FSInfo.XY(:,2),100,pd,'filled');
                if jj == 1
                    cmap(1.5*pd);
                    cc = 1.5*pd;
                end

                dir_name = [rootdir,'/h_pi_figs/'];
                file_name = [rootdir,'/h_pi_figs/',['rot=',num2str(rot/pi*180),'deg.gif']];
            end
            colorbar
            quiver(w.FSInfo.XY(:,1),w.FSInfo.XY(:,2),w.FSInfo.VFxy(:,1),w.FSInfo.VFxy(:,2),0.6,'r')
            axis equal
            %pause(1)
            title(['rot=',num2str(rot/pi*180,3),'deg','-\gamma_{mc}=',num2str(w.gmc,'%.3f')]);
            %caxis([min(cc) max(cc)]);
            hold off

            if save
                if jj == 1
                    mkdir(dir_name);
                end
                frame = getframe(gcf);
                im = frame2im(frame);
                %exportgraphics(gcf,file_name,'Append',true);
                [A,map] = rgb2ind(im,256);
                if jj == 1
                    imwrite(A,map,file_name,"gif","LoopCount",Inf,"DelayTime",0.5);
                else
                    imwrite(A,map,file_name,"gif","WriteMode","append","DelayTime",0.5);
                end
            end
        end
    end
end

Vq = Vq';
Sxxq = Sxxq';
Vstress = Vstress';
Vgmc1 = Vgmc1';
Vgmc2 = Vgmc2';
VB = VB';
Vcol = Vcol';


