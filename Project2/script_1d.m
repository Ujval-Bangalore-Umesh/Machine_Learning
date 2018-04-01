training_data=load('SPECT_train.txt');
validation_data=load('SPECT_valid.txt');
test_data=load('SPECT_test.txt');
D_train=size(training_data,2)-1;
N_train=size(training_data,1);
N_valid=size(validation_data,1);
N_test=size(test_data,1);
%Calling Bayes_Learning
[p1 p2 pc1 pc2]=Bayes_Learning(training_data,validation_data)
%Calling Bayes_Testing
Bayes_Testing(test_data,p1,p2,pc1,pc2)