%load external package that can compute shape context feature
%The package is from: http://www.dabi.temple.edu/~hbling/code_data.htm
addpath common_innerdist;
%Set shape context algorithm parameters
n_dist		= 4;
n_theta		= 8;
bTangent	= 1;
SC = cell(70, 20);
load('imgs.mat','imgs')
for i = 1:70
      for j = 1:20
            % extract shape contest feature for all points on the shape of each image
            [sc,dis_mat,ang_mat] = compu_contour_SC( imgs{i, j}, n_dist, n_theta, bTangent);
            SC{i, j} = sc;
            disp([i,j])
      end
end  