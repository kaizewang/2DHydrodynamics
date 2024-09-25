function para1 = a_jy_proj(para)
   jy = para.src.fth(:,6);
   A = para.FSInfo.ThAth(:,2);
   h = para.hNew;
   para.hNew = h - kron(trapz(para.th,(A.*jy).'.*h,2),jy.')/trapz(para.th,A.*jy.^2); 
   para1 = para;
end