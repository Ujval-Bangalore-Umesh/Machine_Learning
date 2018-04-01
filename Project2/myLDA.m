function [W,eigVal] = myLDA(data,num_principal_components)
    D_train = size(data,2)-1;
    N_train = size(data,1);
    mu = zeros(10,D_train);
    N = zeros(10,1);
       
    for i=1:N_train
        mu(data(i,D_train+1)+1,:) = mu(data(i,D_train+1)+1,:) + data(i,1:D_train);
        N(data(i,D_train+1)+1,1) = N(data(i,D_train+1)+1,1) + 1;
    end
    %The overall mean
    for i = 1:10
        mu(i,:)=mu(i,:)/N(i, 1);
    end
    m = sum(mu)/10;
    %Finding within class scatter
    Sw = zeros(D_train,D_train);
    for i=1:N_train
        Sw = Sw + (data(i,1:D_train)-mu(data(i,D_train+1)+1,:))'*(data(i,1:D_train)-mu(data(i,D_train+1)+1,:));
    end
    %Finding between class scatter
    Sb = zeros(D_train,D_train);
    for i=1:10
        Sb = Sb + N(i)*(mu(i,:)-m)'*(mu(i,:)-m);
    end
    %Using Pseudo Inverse as Inv of a non invertible matrix is infinity.
    [V,D]=eig(pinv(Sw)*Sb);
   %Rearranging the eigen values and eigen vectors
    for i=1:D_train
        for j=i+1:D_train
            if D(i,i)<D(j,j)
                temp1 = D(i,i);
                D(i,i) = D(j,j);
                D(j,j) = temp1;

                temp2 = V(:,i);
                V(:,i) = V(:,j);
                V(:,j) = temp2;
            end
        end
    end
    W = V(:,1:num_principal_components);
    eigVal = D(1:num_principal_components,1:num_principal_components);

end