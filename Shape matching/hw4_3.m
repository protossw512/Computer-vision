%load('SC.mat', 'SC');
%Initialize cost matrix 1 and 2
% cost1 = zeros(1400,1400);
% cost2 = zeros(1400,1400);
% parfor i = 1:1400
%       for j = 1:1400
%          	%Select 2 shapes and assigned for v1, v2
%             v1 = SC{fix((i-1)/20)+1 ,rem(i-1,20)+1};
%             v2 = SC{fix((j-1)/20)+1 ,rem(j-1,20)+1};
%             %Change the direction of v2, according to the request
%             v3 = fliplr(v2);
% %             %Calculate euclidean distance of two paris of shapes
% %             costm1 = pdist2(transpose(v1),transpose(v2),'euclidean');
% %             costm2 = pdist2(transpose(v1),transpose(v3),'euclidean');
% %             [m, n] = size(costm1);
% %             %Initialize accumulated matrix D1 and D2
% %             dis1 = zeros(m, n);
% %             dis2 = zeros(m, n);
% %             %For each pair, apply DTW algorithm to calculate D1 and D2
% %             for x1 = 1:m
% %                 for x2 = 1:n
% %                     if (x1 == 1) && (x2 == 1)
% %                         dis1(x1, x2) = costm1(x1, x2);
% %                         dis2(x1, x2) = costm2(x1, x2);
% %                     elseif x1 == 1
% %                         dis1(x1, x2) = dis1(x1, x2-1) + costm1(x1, x2);
% %                         dis2(x1, x2) = dis2(x1, x2-1) + costm2(x1, x2);
% %                     elseif x2 == 1
% %                         dis1(x1, x2) = dis1(x1-1, x2) + costm1(x1, x2);
% %                         dis2(x1, x2) = dis2(x1-1, x2) + costm2(x1, x2);
% %                     else
% %                         dis1(x1, x2) = min([dis1(x1-1, x2-1),...
% %                             dis1(x1-1, x2), dis1(x1, x2-1)]) + costm1(x1, x2);
% %                         dis2(x1, x2) = min([dis2(x1-1, x2-1),...
% %                             dis2(x1-1, x2), dis2(x1, x2-1)]) + costm2(x1, x2);
% %                     end
% %                 end
% %             end
% %             cost1(i, j) = dis1(m,n);
% %             cost2(i, j) = dis2(m,n);
% 
%             dis1 = dtw(v1,v2);
%             dis2 = dtw(v1,v3);
%             cost1(i, j) = dis1;
%             cost2(i, j) = dis2;
%             disp([i,j]);
%       end
% end

% Compute DTW_cost by finding the minimun cost from C1 and C2
load('cost1.mat','cost1');
load('cost2.mat','cost2');
DTW_cost = zeros(1400, 1400);
for i = 1:1400
    for j = 1:1400
        DTW_cost(i, j) = min(cost1(i, j), cost2(i, j));
    end
end

