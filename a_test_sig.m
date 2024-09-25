sigma0 = [1,0;0,3];%trivial
sigma1 = [1,-1;1,3];%Hall
R = @(th) [cos(th),sin(th);-sin(th),cos(th)];
sigma01 = R(pi/7)'*sigma0*R(pi/7);
sigma02 = R(pi/2)'*sigma01*R(pi/2);
sigma03 = R(pi/2)'*sigma1*R(pi/2);
disp(sigma01)
disp(sigma02)
disp(sigma1)
disp(sigma03)
