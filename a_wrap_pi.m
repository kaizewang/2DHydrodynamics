function y = a_wrap_pi(x)
    y = zeros(size(x));
    for ii = 1:length(x)
        if abs(x(ii))>pi
            y(ii) = mod(x(ii),2*pi);
            if abs(y(ii))>pi
                y(ii) = y(ii) - 2*pi;
            end
        else
            y(ii) = x(ii);
        end
    end
end