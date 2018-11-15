%The best error rate for the MLP was obtained for m=15
traindata = "optdigits_train.txt";
valdata = "optdigits_valid.txt";
train = load(traindata);
valid = load(valdata);
combo = [train; valid];
[z,~] = mlptest(combo,w15,v15);
%Obtaining the principal components
[coeff] = pca(z');
Z = (coeff*z)';
co_label = combo(:,65);
k=10;
color=[1 0.5 0.5;0 0 1;1 0.3 0.5;1 0 1;0.5 0.3 1;0.3 0.6 0.8;0 0 0;0.4 0.6 0.7;0.6 0.7 0.4;0.5 0.3 0.8];
%scatterplot of the data 
%2D plot
figure
for i=1:k
    scatter(Z(co_label(:) == i-1,1),Z(co_label(:) == i-1,2),1, color(i,:));
    title('2D plot of combination of training and validation set');
    xlabel('Prinicpal Component1');
    ylabel('Prinicpal Component2');
    hold on;
end
%Labeling every 5th point in the scatter for reduced overlap
for i=1:length(Z)
    if mod(i,5)==0
        text(Z(i,1),Z(i,2),num2str(co_label(i)),'Color',color(co_label(i)+1,:))
        hold on;
    end
end

%3D plot
figure
for i=1:k
    scatter3(Z(co_label(:) == i-1,1),Z(co_label(:) == i-1,2),Z(co_label(:) == i-1,3),2, color(i,:));
    title('3D plot of combination of training and validation set');
    xlabel('Principal Component1');
    ylabel('Principal Component2');
    zlabel('Principal Component3');
    hold on;
end
%Labeling every 5th point in the scatter for reduced overlap
for i=1:length(Z) 
    if mod(i,5)==0
        text(Z(i,1),Z(i,2),Z(i,3),num2str(co_label(i)),'Color',color(co_label(i)+1,:))
    hold on;
    end
end
