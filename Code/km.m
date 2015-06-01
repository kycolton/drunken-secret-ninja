%% K-Means
%%  Separate data points into K clusters with no other information.
%% Inputs:
%%  A - D-by-N matrix of N points in D dimensions.
%%  K - Integer number of clusters to detect. 
%% Outputs:
%%  C - D-by-K matrix with the learned cluster centroids.
%%  labels - Length N vector with integer (1, 2, ..., K) class assignments.

function [C, labels] = km(A, K)
    % D = 2
    % N = 1000
    [D, N] = size(A); 

    C = zeros(D, K);
    labels = zeros(N, 1);
    r = zeros(K);

% initially picks random data points as centroids    
    
    % creates K random numbers
    rng('shuffle');
    for i = 1:K
        r(i) = 1 + floor(rand()*N);
    end
    
    % assigns centroids with labels 1, 2, ... , K
    for j = 1:K
        for i = 1:D
            C(i, j) = A(i, r(j));
            labels(r(j)) = j;
        end
    end
    
    disp('Starting k-means calculations.');
    
% iterates until classes no longer change
changes = N;
while(changes ~= 0)
 
% assign each observation to nearest centroid
    
    % calculates distance from each point to each centroid
    dist = zeros(K, N);
    for j = 1:K
        for i = 1:N
            dist(j, i) = norm(C(:, j) - A(:, i));
        end
    end
    
    % finds smallest index in the dist matrix (interested in minIndex
    [minValue, minIndex] = min(dist);
    
    % check to see how many indexes changed
    changes = 0;
    for i = 1:N
        if(minIndex(i) ~= labels(i))
            changes = changes + 1;
        end
    end
    disp(horzcat('Changes made: ', num2str(changes)));
   
    % redefines labels output
    labels = minIndex;
    
% relearn centroid based on average of assigned data points
    classSum = zeros(D, K);
    count = zeros(1, K);
    
    % find sum and total number in each class
    for j = 1:K
        for i = 1:N
            if(labels(i) == j)
                for m = 1:D
                    classSum(m, j) = classSum(m, j) + A(m, i);  
                end
                count(j) = count(j) + 1;
            end
        end
    end
    
    % reassign centroids
    for j = 1:K
        for i = 1:D
            C(i, j) = classSum(i, j) / count(j);
        end
    end
end
 
disp('Finsihed k-means calculations. Process completed.');

end