function pd = a_pi_add(th,x)
    F = griddedInterpolant(th,x,'spline','spline');
    tq = linspace(-pi,pi,length(th));
    pd = F(tq) + F(a_wrap_pi(tq+pi));
end