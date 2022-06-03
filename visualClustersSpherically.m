%creating data
%rng(5,'twister');
data = [];
for i=1:10000
%     x = (10+10)*rand - 10;
%     y = (5+5)*rand - 5;
%     z = (1+1)*rand - 1;
    x = (1+1)*rand - 1;
    y = (1+1)*rand - 1;
    z = (1+1)*rand - 1;

    new_dp = [x y z];
    data = [data; new_dp];
end

% normalizing data
for i=1:length(data) 
    vec = [data(i,1) data(i,2) data(i,3)];
    unitVec = vec./sqrt((vec(1)^2) + (vec(2)^2) + (vec(3)^2));
    data(i,:) = unitVec;
end

% clustering
k=6;
class = kmeans(data, k);

% defining color of classes
c = ones(length(class),3);
colors = [
          0 0 1;
          0 1 0;
          0 1 1;
          1 0 0;
          1 0 1;
          1 1 0
          ];
for i=1:length(class)
    c(i,:) = colors(class(i), :);
end

% defining parameters to plot
x = data(:,1); % x data
y = data(:,2); % y data
z = data(:,3); % z data
%c is color of the classes
s = 20; % size of the point

% h = scatter3(x,y,z,s,c,"filled",'o'); % plotting
% alpha = 0.5; % alpha
% set(h, 'MarkerEdgeAlpha', alpha, 'MarkerFaceAlpha', alpha) % setting alpha

% ploting a sphere of base
[sx,sy,sz] = sphere;
figure;
hs1 = surf(sx,sy,sz, 'FaceColor', 'black');
hold on;

% ploting spherical sections by class (different colors)
data = [data class];
for i=1:k
    cluster = data(data(:,4)==i,:);
    cluster(:,4) = [];
    [k,vol] = convhulln(cluster); 
    clx = cluster(:,1);
    cly = cluster(:,2);
    clz = cluster(:,3);
    trisurf(k,clx,cly,clz,'FaceColor',colors(i,:), 'LineStyle', 'none');
    hold on;
end