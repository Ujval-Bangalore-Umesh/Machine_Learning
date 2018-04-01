training_data = load('face_train_data_960.txt');
D_train = size(training_data,2)-1;
N_train = size(training_data,1);

muTrain=mean(training_data(:,1:end-1));
    
j=0;
for K = [10,50,100]
    [W,eigVal] = MyPCA(training_data,K);
    ZTrain = zeros(5,K);
    for i=1:5
        ZTrain(i,:) = (W'*(training_data(i,1:D_train)-muTrain)')';
    end
    %Reconstruction
    Zrecon=(ZTrain*W')+muTrain;
    for i=1:5
        subplot(3,5,i+5*j), imagesc(reshape(Zrecon(i,1:end),32,30)');
    end
    j=j+1;
end