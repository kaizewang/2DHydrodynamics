function setcolormap_angle(arg1,arg2,arg3,arg4)

if 1 == nargin
  ax=gca;
  data=arg1;
  lmin=-pi;
  lmax=pi;
elseif 2 == nargin
  ax=arg1;
  data=arg2;
  lmin=-pi;
  lmax=pi;
elseif 4 == nargin
  ax=arg1;
  data=arg2;
  lmin=arg3;
  lmax=arg4;
end


colmap=cmap_angle(data,lmin,lmax);

[a,b]=bounds(data,'all');

if 10*abs(b-a) < abs(lmax-lmin)
  colormap(ax,'default')
else
  colormap(ax,colmap)
end

end
