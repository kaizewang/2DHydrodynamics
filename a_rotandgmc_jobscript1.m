dress_array = [0.1;0.286;0.343;0.8];
Phiy_cell = cell(length(dress_array),1);
result_cell = Phiy_cell;
para_cell = Phiy_cell;
parfor ii = 1:length(dress_array)
    gmr_array = 1;
    gmc_array = linspace(0,0,1);
    rot_angle = linspace(0,pi/4,1).';
    Ny = 100;
    Nth = 100;
    time = datestr(now,'mmdd-HH-MM-SS');
    Phiy_cell{ii}  = zeros(length(gmc_array),length(rot_angle));
    result_cell{ii}.gmr = gmr_array;
    result_cell{ii}.gmc = gmc_array ;
    result_cell{ii}.dress = dress_array(ii);
    result_cell{ii}.rot_angle = rot_angle;
    result_cell{ii}.Vy = Phiy_cell{ii};
    for kk = 1:length(gmc_array)
        for jj = 1:length(rot_angle)
            if jj == 1 && kk==1
                para_cell{ii} = a_para_init('aa',dress_array(ii),'gmr',gmr_array,...
                    'gmc',gmc_array(kk),'Ny',Ny,'Nth',Nth,'FSrot_angle',rot_angle(1),'jobdis','gmcjobs',...
                    'TS',time);
            else
                para_cell{ii} = a_para_renew(para_cell{ii},'FSrot_angle',rot_angle(jj),'gmc',gmc_array(kk));
            end
            para_cell{ii} = a_cal_source(para_cell{ii});
            para_cell{ii} = a_sc_loop(para_cell{ii});
            a_writehis(para_cell{ii});
            if mod(kk,2) == 0
                Phiy_cell{ii}(kk,end + 1 -jj) = trapz(para_cell{ii}.y,para_cell{ii}.src.Ey);
            else
                Phiy_cell{ii}(kk,jj) = trapz(para_cell{ii}.y,para_cell{ii}.src.Ey);
            end
            result_cell{ii}.Vy = Phiy_cell{ii};
            temp = result_cell{ii};
            aux_parsave([para_cell{ii}.Xfile_name2,'/results.mat'],temp);
        end
        rot_angle = rot_angle(end:-1:1);
    end
end

