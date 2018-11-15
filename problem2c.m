%The best error rate obtained for m=15 used to project the principal components for test dataset.
test = load('optdigits_test.txt');
[z,~] = mlptest(test,w15,v15);
Z = (coeff*z)';
test_label = test(:,65); %test and train labels
color=[1 0.5 0.5;0 0 1;1 0.3 0.5;1 0 1;0.5 0.3 1;0.3 0.6 0.8;0 0 0;0.4 0.6 0.7;0.6 0.7 0.4;0.5 0.3 0.8];
%scatterplot of the data 
k=10;
figure
for i=1:k
    scatter(Z(test_label(:) == i-1,1),Z(test_label(:) == i-1,2),1, color(i,:));
    hold on;
    title('2D plot of test dataset');
    xlabel('Prinicpal Component1');
    ylabel('Prinicpal Component2');
    hold on;
end
for i=1:length(Z)
    if mod(i,5)==0 %Labeling every 5th point in the scatter for reduced overlap
        text(Z(i,1),Z(i,2),num2str(test_label(i)),'Color',color(test_label(i)+1,:))
        hold on;
    end
end
figure
for i=1:k 
    scatter3(Z(test_label(:) == i-1,1),Z(test_label(:) == i-1,2),Z(test_label(:) == i-1,3),2, color(i,:));
    hold on;
end
for i=1:length(Z)
    if mod(i,5)==0
        text(Z(i,1),Z(i,2),Z(i,3),num2str(test_label(i)),'Color',color(test_label(i)+1,:))
        hold on;
        title('3D plot of test dataset');
        xlabel('Prinicpal Component1');
        ylabel('Prinicpal Component2');
        zlabel('principal component3')
        hold on;
    end
end
