function[mu1,mu2,Sigma1,Sigma2] = multiG(train,test,choice)
n=100;
%class segregation
class_labels = train(:,9);
test_class_labels = test(:,9);
test = test(:,1:8);
train = train(:,1:8);
%keeping a count of number in eadch class
count_class1 = 0;count_class2 = 0;

for i = 1 : n
    if(class_labels(i,1)==1)
        count_class1 = count_class1 + 1;
        else
        count_class2 = count_class2 + 1;
    end
end
%Initialising class1 and class2
class1_data = zeros(count_class1,8);
class2_data = zeros(count_class2,8);
index1 = 1;index2 = 1;
for i = 1 : n
    if(class_labels(i,1)==1)
        class1_data(index1,:) = train(i,:);
        index1 = index1 + 1;
    else
        class2_data(index2,:) = train(i,:);
        index2 = index2 + 1;
    end
end

%Learning means
mu1 = mean(class1_data);
mu2 = mean(class2_data);
%Independent S1 and S2
if choice == 1 
    Sigma1 = cov(class1_data);
    Sigma2 = cov(class2_data);
    coeff1 = 1/sqrt(power(2*pi(),4)*det(Sigma1));
    coeff2 = 1/sqrt(power(2*pi(),4)*det(Sigma2));
    error=0;
    for i = 1: n
   
       exp1 = exp(-(test(i,:)-mu1(1,:))*inv(Sigma1)*transpose(test(i,:)-mu1(1,:))/2);
       exp2 = exp(-(test(i,:)-mu2(1,:))*inv(Sigma2)*transpose(test(i,:)-mu2(1,:))/2);
     
       probab1 = coeff1 * exp1;
       probab2 = coeff2 * exp2;
       
       max_log = log((0.6*probab1)/(0.4*probab2));
       if(max_log>0)
           if(test_class_labels(i) ~= 1)
               error = error + 1;
           end
       else
           if(test_class_labels(i) ~= 2)
               error = error + 1;
           end
       end
    end


error = error/100;
disp('mean1 is');
disp(mu2);
disp('mean2 is ');
disp(mu2);
disp('Sigma1 is ');
disp(Sigma1);
disp('Sigma2 is');
disp(Sigma2);
disp('error rate is');
disp(error);
return;
%S1 = S2
elseif choice == 2
    Sigma1 = cov(class1_data);
    Sigma2 = cov(class2_data);
    Sigma = (0.6*Sigma1)+(0.4*Sigma2);
    coeff1 = 1/sqrt(power(2*pi(),4)*det(Sigma));
    coeff2 = 1/sqrt(power(2*pi(),4)*det(Sigma));
    
    error=0;
    for i = 1: n
   
       exp1 = exp(-(test(i,:)-mu1(1,:))*inv(Sigma)*transpose(test(i,:)-mu1(1,:))/2);
       exp2 = exp(-(test(i,:)-mu2(1,:))*inv(Sigma)*transpose(test(i,:)-mu2(1,:))/2);
     
       probab1 = coeff1 * exp1;
       probab2 = coeff2 * exp2;
       
       max_log = log((0.6*probab1)/(0.4*probab2));
       if(max_log>0)
           if(test_class_labels(i) ~= 1)
               error = error + 1;
           end
       else
           if(test_class_labels(i) ~= 2)
               error = error + 1;
           end
       end
    end
    Sigma1 = Sigma;
    Sigma2 = Sigma;
    error = error/100;
    disp('mean1 is ');
    disp('mean2 is ');
    disp(mu2);
    disp('Sigma is ');
    disp(Sigma);
    disp('error rate is ');
    disp(error);
    return;
 %S1 and S2 are diagonals
elseif choice == 3
    Sigma1 = cov(class1_data);
    Sigma2 = cov(class2_data);
 %returns a matrix with diagonal elements
    Sigma1 = diag(diag(Sigma1));
    Sigma2 = diag(diag(Sigma2));
    
    coeff1 = 1/sqrt(power(2*pi(),4)*det(Sigma1));
    coeff2 = 1/sqrt(power(2*pi(),4)*det(Sigma2));
    
    error=0;
    for i = 1: n
   
       exp1 = exp(-(test(i,:)-mu1(1,:))*inv(Sigma1)*transpose(test(i,:)-mu1(1,:))/2);
       exp2 = exp(-(test(i,:)-mu2(1,:))*inv(Sigma2)*transpose(test(i,:)-mu2(1,:))/2);
              
       probab1 = coeff1 * exp1;
       probab2 = coeff2 * exp2;
       
       max_log = log((0.6*probab1)/(0.4*probab2));
       if(max_log>0)
           if(test_class_labels(i) ~= 1)
               error = error + 1;
           end
       else
           if(test_class_labels(i) ~= 2)
               error = error + 1;
           end
       end
    end
    error = error/100;
    disp('mean1 is ');
    disp(mu1);
    disp('mean2 is ');
    disp(mu2);
    disp('Sigma1 is');
    disp(Sigma1);
    disp('Sigma2 is ');
    disp(Sigma2);
    disp('error rate is ');
    disp(error);
    return;
else
    Sigma1 = cov(class1_data);
    Sigma2 = cov(class2_data);
    %returns a matrix with diagonal elements as Eigen Values
    [V1,D1] = eig(Sigma1);
    [V2,D2] = eig(Sigma2);
    coeff1 = 1/sqrt(power(2*pi(),4)*det(D1));
    coeff2 = 1/sqrt(power(2*pi(),4)*det(D2));
    
    error=0;
    for i = 1: 100
   
       exp1 = exp(-(test(i,:)-mu1(1,:))*inv(D1)*transpose(test(i,:)-mu1(1,:))/2);
       exp2 = exp(-(test(i,:)-mu2(1,:))*inv(D2)*transpose(test(i,:)-mu2(1,:))/2);
       
       
       probab1 = coeff1 * exp1;
       probab2 = coeff2 * exp2;
       
       max_log = log((0.6*probab1)/(0.4*probab2));
       if(max_log>0)
           if(test_class_labels(i) ~= 1)
               error = error + 1;
           end
       else
           if(test_class_labels(i) ~= 2)
               error = error + 1;
           end
       end
    end
    error = error/100;
    disp('mean1 is ');
    disp(mu1);
    disp('mean2 is ');
    disp(mu2);
    disp('alpha1 is ');
    disp(D1);
    disp('alpha2 is ');
    disp(D2);
    disp('error rate is ');
    disp(error);
    Sigma1 = D1;
    Sigma2 = D2;
    return;
end
end


    
            
            
            
            
   
   