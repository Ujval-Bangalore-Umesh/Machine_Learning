function [w,step] = perceptron(X,Y,w0,rate)
%w=Weight vector, X=State space feature Matrix, Y=Label vector, w0- Initial
%Vector, Rate= Rate of change of the perceptron classifier.
X=X';
%changed to match matrix dimensions of weights.(w'X)
w = w0;
N = size(X,2);
pos_idx = (Y==1);
neg_idx = (Y==-1);
%Defining the axis for the plot
mxx = max(X(1,:));
mxy = max(X(2,:));
mnx=-1*mxx;
mny=-1*mxy; 

figure;
ginput(1);
err = 1;    
step = 0;
while err > 0  
  for i = 1 : N       
    if sign(w'*X(:,i)) ~= Y(i) %Checking for a wrong decision
        w = w + rate*X(:,i) * Y(i);   %if wrong, then adding to the weight to classify
        x1=mnx:0.01:mxx;
        x2=-(w(1)*x1)/w(2);
        clf;
        hold on
        %Plotting the output
        plot(X(1,pos_idx),X(2,pos_idx),'b*','MarkerSize',10);
        plot(X(1,neg_idx),X(2,neg_idx),'r+','MarkerSize',10);
        plot(X(1,i),X(2,i),'ko','MarkerSize',15);
        plot(x1,x2);
        xlim([mnx mxx]);
        ylim([mny mxy]);
        step = step + 1%counting iterations
        pause(0.5); 
    end
  end
  err = sum(sign(w'*X)~=Y')/N  
end

%With the rate of 0.1, the Iterations for convergence is 14 and the optimal
%w=  1.2934
%   -0.0090 
% The algorithm does not converge for the linearly inseparable case. This
% is because the convergence is dependent on the error of classification
% being =0 for the iterations to 0.
   