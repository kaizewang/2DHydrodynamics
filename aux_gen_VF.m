function vf = aux_gen_VF(para)
    th = para.FSInfo.ThR(:,1);
    th0 = para.FSInfo.th0;
    r0 = para.FSInfo.dress;
    r = para.FSInfo.ThR(:,2);
    vf = zeros(length(th),2);
    t_vec = zeros(2,1);
    n_vec = t_vec;
    for ii = 1:length(th)
        rp = - para.FSInfo.nRot * r0 * sin(para.FSInfo.nRot*(th(ii)+th0));
        t_vec(1) = rp * cos(th(ii)) - r(ii) * sin(th(ii));
        t_vec(2) = rp * sin(th(ii)) + r(ii) * cos(th(ii));
        t_vec = t_vec/norm(t_vec);
        z = t_vec(1) + 1i*t_vec(2);
        n_vec(1) = real(-1i*z);
        n_vec(2) = imag(-1i*z);
        vf(ii,:) = n_vec.';
    end
end
        