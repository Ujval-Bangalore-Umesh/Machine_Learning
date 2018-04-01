function Bayes_Testing(test_data,p1,p2,pc1,pc2)
    error = 0;
    D_test = size(test_data,2)-1;
    N_test = size(test_data,1);
    for i=1:N_test
        p1LH = 1;p2LH = 1;
        for j=1:D_test
            p1LH = p1LH*p1(j)^test_data(i,j)*(1-p1(j))^(1-test_data(i,j));
            p2LH = p2LH*p2(j)^test_data(i,j)*(1-p2(j))^(1-test_data(i,j));
        end
        p1LH = p1LH*pc1;
        p2LH = p2LH*pc2;
        class=0;
        if p1LH/p2LH>1
            class = 1;
        else
            class = 2;
        end
        if class ~= test_data(i,D_test+1)
            error = error+1;
        end        
    end 
    error = error/N_test;
    sprintf('error rate on test set is %f',error)
end