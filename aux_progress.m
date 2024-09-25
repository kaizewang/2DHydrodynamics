function aux_progress(x,N,symbol)
if x>1
    fprintf('\b');
end
wait{1}='|';
wait{2}='/';
wait{3}='-';
wait{4}='\\';
if find(~mod(x,ceil(N/10)))
    fprintf([symbol ' ']);
else
    fprintf(wait{mod(x,4)+1});
end
if x==N
    fprintf('\n');
end
end