function [z,w,v] = mlptrain(traindata,valdata,m,k)
train = load(traindata);
[rows,d]=size(train);
X = train(:,1:d-1);
X = [ones(rows,1) X];
ita = 0.0001;
rng(21323124);
r=zeros(rows,k);
%Hot encoding to obtain rt
for i=1:rows
    label=train(i,end)+1;
    r(i,label)=1;
end
y = zeros(rows,k);
val = load(valdata);
%Random initialization of weights w and v
w=random('unif',-0.01,0.01,[m,d]);
v=random('unif',-0.01,0.01,[k,m+1]);

error = [1 2];
iter = 2;
while(abs(error(iter)-error(iter-1))>0.001) %convergence criteria
    iter = iter+1;
    if(mod(iter,1000)==0) %Convergence enhancement
        ita = ita/5;
    end
    for i=1:rows
        %Forward step
        z = (w*X(i,:)')';
        %Applying RELU
        z(z<0) = 0;
        a = [1 z];
        %Output using softmax
        o = a*v';
        y(i,:) = exp(o) / sum(exp(o));
        %Back propagation step-calculation of delta v and delta w.
        dv = ita * (r(i,:) - y(i,:))' * a(:,2:end);
        dw = ita * ((r(i,:) - y(i,:)) * v(:,2:end))' * X(i,:);
        dw(w*X(i,:)' < 0,:)=0;
        %Update of weights
        v(:,2:end) = v(:,2:end)+dv;
        w = w+dw;
    end
    error(iter) = -sum(sum(r.*log(y)));
end
z = w*X';
z(z<0) = 0;%Relu for combined z
end