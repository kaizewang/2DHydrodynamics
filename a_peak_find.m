function Vmq = a_peak_find(Vq)
    nlines = size(Vq,1);
    n = size(Vq,2);
    %nlines = 17;
    Vmq = zeros(nlines,1);
    for ii = 1:nlines
        Vmq(ii) = max(Vq(ii,1:n),[],"ComparisonMethod",'abs');
    end
end