contents = dir('*.jpg') % or whatever the filename extension is
crop = [190 52 151 212] % initial crop to crop object in the first frame
result = [190,52,341,264] % add bounding box of the first frame into result
for i = 1:(numel(contents)-1) %loop through all images
  %read and gray two consecutive frames
  filename1 = contents(i).name;
  filename2 = contents(i + 1).name;
  boxImage = rgb2gray(imread(filename1));
  boxImage = imcrop(boxImage,crop); %crop image according to the bounding box caculated from last loop
  sceneImage = rgb2gray(imread(filename2));
  %apply SURF feature dectors to detecte interest points
  boxPoints = detectSURFFeatures(boxImage);
  scenePoints = detectSURFFeatures(sceneImage);
  %extract SURF features
  [boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
  [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);
  %
  boxPairs = matchFeatures(boxFeatures, sceneFeatures);
  matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
  matchedScenePoints = scenePoints(boxPairs(:, 2), :);
  [tform, inlierBoxPoints, inlierScenePoints] = ...
      estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');
  %figure;
  %showMatchedFeatures(boxImage, sceneImage, inlierBoxPoints, ...
  %    inlierScenePoints, 'montage');
  boxPolygon = [1, 1;...                           % top-left
          size(boxImage, 2), 1;...                 % top-right
          size(boxImage, 2), size(boxImage, 1);... % bottom-right
          1, size(boxImage, 1);...                 % bottom-left
          1, 1];                   % top-left again to close the polygon
  newBoxPolygon = transformPointsForward(tform, boxPolygon);
  %figure;
  %imshow(sceneImage);
  %hold on;
  %line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
  %title('Detected Box');
  center_x = (max(newBoxPolygon(:, 1)) + min(newBoxPolygon(:, 1))) / 2.0;
  center_y = (max(newBoxPolygon(:, 2)) + min(newBoxPolygon(:, 2))) / 2.0;
  length = max(newBoxPolygon(:, 1)) - min(newBoxPolygon(:, 1));
  height = max(newBoxPolygon(:, 2)) - min(newBoxPolygon(:, 2));
  if length - crop(3) >= 3
      length = crop(3) + 3;
  end
  if height - crop(4) >= 3
      height = crop(4) + 3;
  end
  left_x = center_x - length / 2;
  left_y = center_y - height / 2;
  crop = [left_x, left_y, length, height];
  result = [result ; [newBoxPolygon(1,1), newBoxPolygon(1,2),...
      newBoxPolygon(3,1), newBoxPolygon(3,2)]];
  [path name] = fileparts(filename1);
  out_filename = sprintf('%s-tract.jpg', filename1);
  %write text output to 'out_filename'
  %saveas(gcf,out_filename);
  %close all;
end
dlmwrite('boundingbox.txt',result)


