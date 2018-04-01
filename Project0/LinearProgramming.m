A = load('data2.mat');

X = A.X
y= A.y
%Linear programming is used to minimize the error for Linearly inseparable
%classification problem.
[m,n]=size(X);
f=[zeros(n,1);ones(m,1)]; 
A1=[X.*repmat(y,1,n),eye(m,m)];
A2=[zeros(m,n),eye(m,m)];
A=-[A1;A2];
b=[-ones(m,1);zeros(m,1)];
x = linprog(f,A,b);
w=x(1:n);

X = X';
%plot for output
pos_idx = (y == 1);
neg_idx = (y == -1);

Xmax = max(X(1,:)); 
Xmin = min(X(1,:));

Ymax = max(X(2,:));
Ymin = min(X(2,:));
figure;
clf
hold on;
x1 = Xmin:0.01:Xmax;
x2 = (-w(1)*x1)/w(2);
plot(X(1,pos_idx),X(2,pos_idx),'r*','MarkerSize',12);
plot(X(1,neg_idx),X(2,neg_idx),'g+','MarkerSize',12);
plot(x1,x2);