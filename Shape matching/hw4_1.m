label = {'apple', 'bat', 'beetle', 'bell', 'bird', 'bone', 'bottle',...
'brick', 'butterfly','camel', 'car', 'carriage', 'cattle', 'cellular_phone','chicken',...
'children','chopper','classic','comma','crown','cup','deer','device0','device1',...
'device2','device3','device4','device5','device6','device7','device8','device9','dog',...
'elephant','face','fish','flatfish','fly','fork','fountain','frog','glas','guitar',...
'hammer','hat','hcircle','Heart','horse','horseshoe','jar','key','lizzard',...
'lmfish','Misk','octopus','pencil','personal_car','pocket','rat','ray','sea_snake',...
'shoe','spoon','spring','stef','teddy','tree','truck','turtle','watch'};

%extract the shape of each image and save to a 70x20 cell
imgs = cell(70,20);
for i = 1:70
      for j = 1:20
         %Get the filename to access
         name = sprintf('%s%s%d%s', char(label(i)),'-',j,'.gif');
         type1  = exist(name);
         if type1 == 0
             %The single digit number is in the format of 1, 2, 3, ... 
             img = imread(sprintf('%s%s%d%s', char(label(i)),'-0',j,'.gif'));
         else
             %Thye signle digit number is in the format of 01, 02, 03, ...
             img = imread(name);
         end
         %Downsamle the image since it is too larg for matching algorithm 
         img = imresize(img, 0.25);
         %Compute the boundaries for each img
         B = bwboundaries(img,'noholes');
         imgs{i,j} = B{1};
       end
end