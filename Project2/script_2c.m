
%Q2d
training_data = load('optdigits_train.txt');
test_data = load('optdigits_test.txt');
N_train = size(training_data,1);
N_test = size(test_data,1);
D_train = size(training_data,2)-1;


for L=[2,4,9]
    [W,eigVal] = myLDA(training_data,L);

    ZTrain = zeros(N_train,L+1);
    %Projecting the Training_data
    for i=1:N_train
        ZTrain(i,1:L) = (W'*training_data(i,1:D_train)')';
        ZTrain(i,L+1) = training_data(i,D_train+1);
    end
    ZTest = zeros(N_test,L+1);
    %Projecting the test_data
    for i=1:N_test
        ZTest(i,1:L) = (W'*test_data(i,1:D_train)')';
        ZTest(i,L+1) = test_data(i,D_train+1);
    end
    for k=[1,3,5]
        error = myKNN(ZTrain,ZTest,k);
        sprintf('The error rate for L=%d,k=%d is %f',L,k,error)
    end
end
%*************************************************************%
%Q2e
training_data = load('optdigits_train.txt');
test_data = load('optdigits_test.txt');
data = [training_data;test_data];
D_train = size(data,2)-1;
N_data = size(data,1);
L = 2;

[W] = myLDA(data,L);

Z = zeros(N_data,L+1);
%Projecting data into Z
for i=1:N_data
    Z(i,1:L) = ( W'*data(i,1:D_train)')';
    Z(i,L+1) = data(i,D_train+1);
end
%Plot
scatter(Z(:,1),Z(:,2),10,[0.5 0.5 0.5]);
color_array = {[1 0 0],[0 0 1],[0 1 0],[0 1 1],[0 0 0],[1 0 0.5],[0.5 0.5 0],[0.8 0.2 0.1],[0.5 0 0.2],[0 0.4 0]};
xlabel('Prinicpal Component1');
ylabel('Prinicpal Component2');
for i=1:N_data
    if mod(i,10)==0
        text(Z(i,1),Z(i,2),int2str(Z(i,3)),'Color',color_array{Z(i,3)+1},'FontSize',12);
    end
end