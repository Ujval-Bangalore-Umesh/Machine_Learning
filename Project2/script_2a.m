training_data=load("optdigits_train.txt");
test_data=load("optdigits_test.txt");
N=size(training_data,2);
Xtrain=training_data(:,1:N-1);
Ytrain=training_data(:,N);
Xtest=test_data(:,1:N-1);
Ytest=test_data(:,N);
for k=1:2:7
error_rate=myKNN(training_data, test_data,k);
sprintf('The error rate for k =%d is %f',k,error_rate)
end

