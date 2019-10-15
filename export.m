
matrix = zeros(size(m.instruments(1).data(2).values,2),2);
matrix(1:end,1) = (1:size(m.instruments(1).data(2).values,2));
matrix(1:end,2) = m.instruments(1).data(2).values;

fid = fopen('test.csv', 'w') ;  
fprintf(fid, '%s , % s\n', ["cycle counter" ; "values"]) ;% create identical header
fprintf(fid, '%d , %d\n',matrix'); % fill the data
fclose(fid) ;

%csvwrite('test.csv',matrix);