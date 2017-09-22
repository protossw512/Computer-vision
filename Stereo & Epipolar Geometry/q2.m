img1_points = importdata('img51.txt');
img2_points = importdata('img52.txt');

fRANSAC = estimateFundamentalMatrix(img1_points,...
    img2_points,'Method','RANSAC',...
    'NumTrials',100,'DistanceThreshold',0.01);

im1 = imread('image51.png');
im2 = imread('image52.png');

% read in fundamental matrix
F0 = fRANSAC;

left_img = rgb2gray(im1);
right_img = rgb2gray(im2);
%left_img = im1;
%right_img = im2;
%apply SURF feature dectors to detecte interest points
left_points = detectSURFFeatures(left_img);
right_points = detectSURFFeatures(right_img);
%extract SURF features
[left_features, left_points] = extractFeatures(left_img, left_points);
[right_features, right_points] = extractFeatures(right_img, right_points);
%matche interesting points of two pircutres
pairs = matchFeatures(left_features, right_features);
matchedleft_points = left_points(pairs(:, 1), :);
matchedright_points = right_points(pairs(:, 2), :);
[tform, inlierleft_points, inlierright_points] = ...
    estimateGeometricTransform(matchedleft_points, matchedright_points, 'projective');

matched_left = inlierleft_points.Location;
matched_right = inlierright_points.Location;
num_points = inlierleft_points.Count;

%Calcuate (qi`.T F(0) qj`) for each point
fundamental_equation = [];
for i = 1 : num_points
    temp = [matched_right(i, :) 1] * F0 * [matched_left(i,:) 1].';
    fundamental_equation = [fundamental_equation temp];
end

%Sort matched points to find best 30 pairs(2.4).
matched_points = [abs(fundamental_equation.') matched_left matched_right];
matched_points = sortrows(matched_points);
img1_points = [img1_points; matched_points(1:30,2:3)];
img2_points = [img2_points; matched_points(1:30,4:5)];

%Calculate F(1)
fRANSAC1 = estimateFundamentalMatrix(img1_points,...
    img2_points,'Method','RANSAC',...
    'NumTrials',10000,'DistanceThreshold',0.0005);


% read in fundamental matrix
F1 = fRANSAC1;

point1 = [559 491];
point1_mirror = [634 494];
point2 = [983 440];
point2_mirror = [1035 443];

%figure 1b
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
epiLines1 = epipolarLine(F1, point1);
points1 = lineToBorderPoints(epiLines1,size(im2));
line(points1(:,[1,3])',points1(:,[2,4])','Color','green','LineWidth', 2);
truesize;
plot(point1_mirror(1),point1_mirror(2),'o','MarkerEdgeColor','red','LineWidth', 2);


%figure 2b
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
epiLines4 = epipolarLine(F1', point2_mirror);
points4 = lineToBorderPoints(epiLines4,size(im1));
line(points4(:,[1,3])',points4(:,[2,4])','Color','green','LineWidth', 2);
truesize;
plot(point2(1),point2(2),'o','MarkerEdgeColor','red','LineWidth', 2);

%Calculate and plot epipoles
imageSize1 = size(im1);
imageSize2 = size(im2);
[isIn1,epipole1] = isEpipoleInImage(F1,imageSize1);
figure;
h1 = subplot(1, 2, 1, 'align');
p = get(h1, 'pos');
p(3) = p(3) + 0.1;
set(h1, 'pos', p);
imshow(im1);
title('Epipole on Image 1');
hold on;
set(gca, 'XLimMode', 'Auto', 'YLimMode', 'Auto')
plot(epipole1(1),epipole1(2),'o','MarkerEdgeColor','green','LineWidth', 2);

[isIn2,epipole2] = isEpipoleInImage(F1',imageSize2);
h2 = subplot(1, 2, 2, 'align');
p = get(h2, 'pos');
p(3) = p(3) + 0.1;
set(h2, 'pos', p);
imshow(im2);
title('Epipole on Image 1');
hold on;
set(gca, 'XLimMode', 'Auto', 'YLimMode', 'Auto')
plot(epipole2(1),epipole2(2),'o','MarkerEdgeColor','green','LineWidth', 2);
vgg_gui_F(im1, im2, F1')
      