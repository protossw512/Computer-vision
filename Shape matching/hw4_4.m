%load('DTW_cost.mat', 'DTW_cost');
%Set paramater K
k = 5;
%Initialize error matrix for each object
single_err = zeros(1400, 1);

%Calculate accuracy for each object
for i = 1:1400
    % Sort DTW cost and choose the top 2 to k + 1 element (top 1 is 0, self)
    [ASorted, AIdx] = sort(DTW_cost(i,:));
    smallestNElements = ASorted(2:k+1);
    smallestNIdx = AIdx(2:k+1);
    temp = 0;
    % Loop through each matched shape to see if it is correctely matched
    for idx = 1:numel(smallestNIdx)
        element = smallestNIdx(idx);
        if (fix((i-1)/20) + 1) ~= (fix((element-1)/20) + 1)
            temp = temp + 1;
        end
        % Caculate matching error for each object
        single_err(i, 1) = temp / k;
    end
end

%Initialize class error matrix
object_err = zeros(70, 1);

%Calculate average error rate for each class. Note that (fix((i-1)/20)+1)
%is one class index
for i = 1:1400
    object_err((fix((i-1)/20)+1), 1) = object_err((fix((i-1)/20)+1), 1) + ...
        single_err(i, 1);
end
% Take average
object_err = object_err / 70;

total_err = 0;
%Calculate total error
for i = 1:70
    total_err = total_err + object_err(i, 1);
end

total_err = total_err / 20;
    


    
    