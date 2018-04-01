function[V Eigen]=MyPCA(data,K)
sigma=cov(data(:,1:end-1));
[V Eigen]=eigs(sigma,K);
end