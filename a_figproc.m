gmc1 = gmc_array;
ind = size(VV{1},2)/2;
for ii = 1:length(VV)%dress loop
    cnt = 0;
    for jj = 1:length(gmc_array)
        if jj~=3&&jj~=13
            cnt = cnt + 1;
            u(ii,cnt) = VV{ii}(jj,ind)./VV{ii}(1,ind);
        end
    end
end
gmc1(3) = [];
gmc1(12) = [];
imagesc(gmc1,dress,u);
cmap(u);
colorbar
[gc,d] = ndgrid(gmc1,dress);
Fq = griddedInterpolant(d',gc',u);
gc = linspace(gmc1(1),gmc1(end),100);
ds = linspace(dress(1),dress(end),100);
[gcq,dq] = ndgrid(gc,ds);
uq = Fq(dq',gcq');
figure
imagesc(gc,ds,uq);
cmap(uq)