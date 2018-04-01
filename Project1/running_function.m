%Running Function
train = load('training_data.txt');
test = load('test_data.txt');
choice = 1;
[mu1,mu2,Sigma1,Sigma2]=multiG(train,test,choice);

   