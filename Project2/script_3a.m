training_data = load('face_train_data_960.txt');
test_data = load('face_test_data_960.txt');
data = [training_data;test_data];
D_train = size(data,2)-1;
dataSize = size(data,1);

K = 5;
[W,eigVal] = MyPCA(data,K);
K = size(eigVal,1);
W=W';
for i=1:K
   subplot(1,K,i), imagesc(reshape(W(i,1:end),32,30)');
end