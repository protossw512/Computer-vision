%load data
est = load('estimation.txt');
gt = load('gt.txt');
dist = []; %store Euclidean distances for all frames
%calculate Euclidean distance for each frame
for i = 1:124
    estcenter = [(est(i, 1) + est(i, 3)) / 2.0,...
        (est(i, 2) + est(i, 4)) / 2.0];
    gtcenter = [(gt(i, 1) + gt(i, 3)) / 2.0,...
        (gt(i, 2) + gt(i, 4)) / 2.0];
    eucli = ((estcenter(1) - gtcenter(1))^2 + ...
        (estcenter(2) - gtcenter(2))^2)^0.5;
    dist = [dist; eucli];
end;
avg_dist = mean(dist); %calculate average Euclidean distance
%write result to error.txt file
fid = fopen('error.txt', 'w');
fprintf(fid, 'Average Euclidean distance: %f\n', avg_dist);
fprintf(fid, 'All Euclidean distances:\n');
fclose(fid);
dlmwrite('error.txt',dist,'-append');