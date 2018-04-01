function[p1 p2 pc1 pc2]=Bayes_Learning(training_data,validation_data)
% training_data=load('SPECT_train.txt');
% validation_data=load('SPECT_valid.txt');

D_train=size(training_data,2)-1;
N_train=size(training_data,1);
N_valid=size(validation_data,1);

p=zeros(2,D_train);
N_class = zeros(2,1);
for i=1:N_train
        p(training_data(i,D_train+1),:) = p(training_data(i,D_train+1),:) + training_data(i,1:D_train); 
        N_class(training_data(i,D_train+1),1) = N_class(training_data(i,D_train+1),1) + 1;
end

    p1 = p(1,:)/N_class(1);
    p2 = p(2,:)/N_class(2);
    minerror=1;
    pc1_minerror=0;
    for s= [-5:1:5]
        error=0;
        pc1 = 1/(1+exp(-s));
        pc2 = 1-pc1;
        for i=1:N_valid
            p1LH = 1;p2LH = 1;
            for j=1:D_train
                p1LH = p1LH*p1(j)^validation_data(i,j)*(1-p1(j))^(1-validation_data(i,j));
                p2LH = p2LH*p2(j)^validation_data(i,j)*(1-p2(j))^(1-validation_data(i,j));
            end
            p1LH = p1LH*pc1;
            p2LH = p2LH*pc2;
            class=0;
            if p1LH/p2LH>1
                class = 1;
            else
                class = 2;
            end
            if class ~= validation_data(i,D_train+1)
                error = error+1;
            end
        end
        error = error/N_valid;
        sprintf('validation error for sigma = %d is %f',s,error)
        if error<minerror
            minerror = error;
            pc1_minerror = pc1;
        end
    end
    pc1 = pc1_minerror; 
    pc2 = 1-pc1;
end