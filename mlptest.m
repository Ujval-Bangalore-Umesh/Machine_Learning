function [z,error_rate] = mlptest(testdata,w,v)
if(ischar(testdata)==1)
   test = load(testdata);
else
    test = testdata;
end
k=10;
[rows,d]=size(test);
X = test(:,1:d-1);
X = [ones(rows,1) X];
label = test(:,65)+1;
r=zeros(rows,k);
%Hot encoding for obatining r
for i=1:rows
    label1=test(i,end)+1;
    r(i,label1)=1;
end
y = zeros(rows,k);
%forward step for 1 epoch on test data
count = 0;
for i=1:rows
    z = (w*X(i,:)')'; 
    z(z<0) = 0; %RELU function
    a = [1 z];
    o = a*v';
    y(i,:) = exp(o) / sum(exp(o));
    [~,I] = max(y(i,:)); %Obtaining max of the softmax for error calculation
    if(I == label(i))
      count = count + 1;
    end
end
%Returning z
z = w*X';
z(z<0) = 0;
%Calculating error rate
error_rate=(1-count/rows) * 100

