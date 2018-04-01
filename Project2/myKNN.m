function [error_rate] = myKNN(training_data,test_data,k)
N = size(test_data,1);
test_label = test_data(:,end);
for i =1 : size(k,1)
    [~, I] = pdist2(training_data(:,1:end-1),test_data(:,1:end-1),'euclidean','Smallest',k(i));
    I = I';
    label_gen = zeros(N,k(i));
for j = 1 : k(i)
    label_gen(:,j) = training_data(I(:,j),end);
end
count = 0;
most_freq = mode(label_gen,2);

for j = 1 : N
    if(most_freq(j) ~= test_label(j))
        count = count + 1;
    end
end
k(i);
error_rate(i) = count / N;
end
end