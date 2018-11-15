traindata = 'optdigits_train.txt';
valdata = 'optdigits_valid.txt';
k=10;
%Initialising error rates for tabulation
error_rate = [3,0,0;6,0,0;9,0,0;12,0,0;15,0,0;18,0,0];

% Obtaining z,w,v,error for m=3 units
[z3,w3,v3] = mlptrain(traindata,valdata,3,k);
fprintf("\n Training error rate for m = 3 is:")
[z,error]=mlptest(traindata,w3,v3);
error_rate(1,2)=error;
fprintf("\n Validation error rate for m = 3 is:")
[~,error]=mlptest(valdata,w3,v3);
error_rate(1,3)=error;

% Obtaining z,w,v,error for m=6 units
[z6,w6,v6] = mlptrain(traindata,valdata,6,k);
fprintf("\nTraining error rate for m = 6 is:")
[~,error]=mlptest(traindata,w6,v6);
error_rate(2,2)=error;
fprintf("\nValidation error rate for m = 6 is:")
[~,error]=mlptest(valdata,w6,v6);
error_rate(2,3)=error;

% Obtaining z,w,v,error for m=9 units
[z9,w9,v9] = mlptrain(traindata,valdata,9,k);
fprintf("\nTraining error rate for m = 9 is:")
[~,error]=mlptest(traindata,w9,v9);
error_rate(3,2)=error;
fprintf("\nValidation error rate for m = 9 is:")
[~,error]=mlptest(valdata,w9,v9);
error_rate(3,3)=error;

% Obtaining z,w,v,error for m=12 units
[z12,w12,v12] = mlptrain(traindata,valdata,12,k);
fprintf("\nTraining error rate for m = 12 is:")
[~,error]=mlptest(traindata,w12,v12);
error_rate(4,2)=error;
fprintf("\nValidation error rate for m = 12 is:")
[~,error]=mlptest(valdata,w12,v12);
error_rate(4,3)=error;

% Obtaining z,w,v,error for m=15 units
[z15,w15,v15] = mlptrain(traindata,valdata,15,k);
fprintf("\nTraining error rate for m = 15 is:")
[~,error]=mlptest(traindata,w15,v15);
error_rate(5,2)=error;
fprintf("\nValidation error rate for m = 15 is:")
[~,error]=mlptest(valdata,w15,v15);
error_rate(5,3)=error;

% Obtaining z,w,v,error for m=18 units
[z18,w18,v18] = mlptrain(traindata,valdata,18,k);
fprintf("\nTraining error rate for m = 18 is:")
[~,error]=mlptest(traindata,w18,v18);
error_rate(6,2)=error;
fprintf("\nValidation error rate for m = 18 is:")
[~,error]=mlptest(valdata,w18,v18);
error_rate(6,3)=error;

%Plot of error rates with respect to hidden units.
figure;
plot(error_rate(:,1),error_rate(:,2))
xlabel('Hidden units');
ylabel('Error rate in %');
hold on;
plot(error_rate(:,1),error_rate(:,3))
xlabel('Hidden units') ;
ylabel('Error rate in %');
legend('Training data','Validation data')

%Calculation of error rate for test set based on the best error rate for
%m=15.

fprintf("\nError rate for test data selecting k = 15 is:")
test = 'optdigits_test.txt';
[~,rate]=mlptest(test,w15,v15);
