img1 = importdata('img51.txt');
img2 = importdata('img52.txt');

fRANSAC = estimateFundamentalMatrix(img1,...
    img2,'Method','RANSAC',...
    'NumTrials',100,'DistanceThreshold',0.01);

im1 = imread('image51.png');
im2 = imread('image52.png');

% read in fundamental matrix
F0 = fRANSAC;
point1 = [559 491];
point1_mirror = [634 494];
point2 = [983 440];
point2_mirror = [1035 443];

%figure 1a
figure;
h1 = subplot(1, 2, 1, 'align');
p = get(h1, 'pos');
p(3) = p(3) + 0.08;
set(h1, 'pos', p);
imshow(im1);
title('Point in First Image');
hold on;
plot(point1(1),point1(2),'o','MarkerEdgeColor','green','LineWidth', 2);

h2 = subplot(1, 2, 2, 'align');
p = get(h2, 'pos');
p(3) = p(3) + 0.08;
set(h2, 'pos', p);
imshow(im2);
title('Epipolar Line in Second Image');
hold on;
epiLines1 = epipolarLine(F0, point1);
points1 = lineToBorderPoints(epiLines1,size(im2));
line(points1(:,[1,3])',points1(:,[2,4])','Color','green','LineWidth', 2);
truesize;
plot(point1_mirror(1),point1_mirror(2),'o','MarkerEdgeColor','red','LineWidth', 2);


%figure 2a
figure;
h1 = subplot(1, 2, 2, 'align');
p = get(h1, 'pos');
p(3) = p(3) + 0.08;
set(h1, 'pos', p);
imshow(im2);
title('Point in Second Image');
hold on;
plot(point2_mirror(1),point2_mirror(2),'o','MarkerEdgeColor','green','LineWidth', 2);

h2 = subplot(1, 2, 1, 'align');
p = get(h2, 'pos');
p(3) = p(3) + 0.08;
set(h2, 'pos', p);
imshow(im1);
title('Epipolar Line in First Image');
hold on;
epiLines4 = epipolarLine(F0', point2_mirror);
points4 = lineToBorderPoints(epiLines4,size(im1));
line(points4(:,[1,3])',points4(:,[2,4])','Color','green','LineWidth', 2);
truesize;
plot(point2(1),point2(2),'o','MarkerEdgeColor','red','LineWidth', 2);

% imageSize1 = size(im1);
% imageSize2 = size(im2);
% [isIn1,epipole1] = isEpipoleInImage(F0,imageSize1);
% figure;
% h1 = subplot(1, 2, 1, 'align');
% p = get(h1, 'pos');
% p(3) = p(3) + 0.1;
% set(h1, 'pos', p);
% imshow(im1);
% title('Epipole on Image 1');
% hold on;
% set(gca, 'XLimMode', 'Auto', 'YLimMode', 'Auto')
% plot(epipole1(1),epipole1(2),'o','MarkerEdgeColor','green','LineWidth', 2);
% 
% [isIn2,epipole2] = isEpipoleInImage(F0',imageSize2);
% h2 = subplot(1, 2, 2, 'align');
% p = get(h2, 'pos');
% p(3) = p(3) + 0.1;
% set(h2, 'pos', p);
% imshow(im2);
% title('Epipole on Image 1');
% hold on;
% set(gca, 'XLimMode', 'Auto', 'YLimMode', 'Auto')
% plot(epipole2(1),epipole2(2),'o','MarkerEdgeColor','green','LineWidth', 2);