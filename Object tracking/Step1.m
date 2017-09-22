%This code only visualize 1 pictures, you may change file name and run it 3
%times to get 3 visualizations
img = rgb2gray(imread('img0100.jpg'));  
imgPoints = detectSURFFeatures(img);    %use SURF feature detector to find interest points
[imgFeatures, imgPoints] = extractFeatures(img, imgPoints);
figure;
imshow(img);
hold on;
plot(imgPoints.selectStrongest(100), 'showOrientation', true); %plot top 100 strongest points

