training_data = load('face_train_data_960.txt');
test_data = load('face_test_data_960.txt');
D_train = size(training_data,2)-1;
N_train = size(training_data,1);
N_test = size(test_data,1);

%PCA function and estimating number of features
sigma=cov(training_data(:,1:end-1));
[V Eigen]=eigs(sigma,960);
Eigen=diag(Eigen);
for i=1:length(Eigen)
    pov(i)=sum(Eigen(1:i))/sum(Eigen);
    if(pov(i)<0.9)
        K=i+1;
    end
end
plot(1:960,pov);
title('Proportion of Variance plot')
xlabel('Eigen Vectors')
ylabel('Proportion of Variance')
text(K,0.9,'K=41,pov>0.9');
[W,eigVal] = MyPCA(training_data,K);
K = size(eigVal,1);

muTrain=mean(training_data(:,1:end-1));
muTest=mean(test_data(:,1:end-1));

%projecting the train data into Z
ZTrain = zeros(N_train,K+1);
for i=1:N_train
    ZTrain(i,1:K) = (W'*(training_data(i,1:D_train)-muTrain)')';
    ZTrain(i,K+1) = training_data(i,D_train+1);
end
%projecting the test data into Z
ZTest = zeros(N_test,K+1);
for i=1:N_test
    ZTest(i,1:K) = (W'*(test_data(i,1:D_train)-muTest)')';
    ZTest(i,K+1) = test_data(i,D_train+1);
end
%Performing KNN and display of error
for i=[1,3,5,7]
    error = myKNN(ZTrain,ZTest,i);
    sprintf('The error rate for k= %d is %f',i,error) 
end
