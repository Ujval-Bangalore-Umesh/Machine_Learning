%Q2b
training_data=load("optdigits_train.txt");
test_data=load("optdigits_test.txt");
data=training_data;
N=size(training_data,2);
Xtrain=training_data(:,1:N-1);
Ytrain=training_data(:,N);
Xtest=test_data(:,1:N-1);
Ytest=test_data(:,N);
sigma=cov(data(:,1:end-1));
[V,Eigen]=eigs(sigma,64);
Eigen=diag(Eigen);
for i=1:length(Eigen)
    pov(i)=sum(Eigen(1:i))/sum(Eigen);
    if(pov(i)<0.9)
        K=i+1;
    end
end
figure
plot(1:64,pov);
title('Proportion of Variance plot')
xlabel('Eigen Vectors')
ylabel('Proportion of Variance')
text(K,0.9,'K=21,pov>0.9');
[V,Eigen]=MyPCA(data,K);
%The value of K=21 after plotting proportion of variance

mu_train=mean(Xtrain);
mu_test=mean(Xtest);

Z_train=(Xtrain-mu_train)*V;
Z_test=(Xtest-mu_test)*V;

Z_train(:,K+1)=Ytrain(:,1);
Z_test(:,K+1)=Ytest(:,1);

for k=1:2:7
error_rate=myKNN(Z_train,Z_test,k);
sprintf('The error rate for k =%d is %f',k,error_rate)
end

%****************************************************************%
%Q2c

training_data = load('optdigits_train.txt');
test_data = load('optdigits_test.txt');
data = [training_data;test_data];
D_train = size(data,2)-1;  
N_train = size(data,1);

[W,eigVal] = MyPCA(data,2);
K = size(eigVal,1);
figure
muData=mean(data(:,1:end-1));
%Projecting the data into Z
Z = zeros(N_train,K+1);
for i=1:N_train
    Z(i,1:K) = (W'*(data(i,1:D_train)-muData)')';
    Z(i,K+1) = data(i,D_train+1);
end
%Plot of the projected space with labeling of some data points
scatter(Z(:,1),Z(:,2),10,[0.5 0.5 0.5]);
color_array = {[1 0 0],[0 0 1],[0 1 0],[0 1 1],[0 0 0],[1 0 0.5],[0.5 0.5 0],[0.8 0.2 0.1],[0.5 0 0.2],[0 0.4 0]};
xlabel('Prinicpal Component1');
ylabel('Prinicpal Component2');
for i=1:N_train
    if mod(i,10)==0
        text(Z(i,1),Z(i,2),int2str(Z(i,3)),'Color',color_array{Z(i,3)+1},'FontSize',12);
    end
end
