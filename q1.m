clc;
clear all;
close all;

im = imread('bottles.tif');
figure, imshow(im)
imbw = im2bw(im,0.7);
 
se13 = strel('disk',4);
IM5 = imopen(imbw,se13);
[L n] = bwlabel(IM5);

figure, imshow(IM5)
% rect2 = getrect;
rect2 = [198.0000   65.0000  116.0000   25.0000];
S = IM5(rect2(2): rect2(2)+rect2(4), rect2(1):rect2(1)+rect2(3),:);

C = zeros(size(IM5));
C(rect2(2): rect2(2)+rect2(4), rect2(1):rect2(1)+rect2(3),:) = IM5(rect2(2): rect2(2)+rect2(4), rect2(1):rect2(1)+rect2(3),:);
figure, imshow(C)

[Label n1] = bwlabel(C);
cent  = regionprops(C,'Centroid');

figure, imshow(IM5);
hold on;
for i = 1:numel(cent)
    plot(cent(i).Centroid(1),cent(i).Centroid(2),'ro');
end

D = zeros(size(IM5));
D = IM5;
for i = 1 : cent.Centroid(2)
    D(i,:) = 0;
end

se13 = strel('disk',2);
D1 = imopen(D,se13); 
figure, imshow(D1)
D2 = im2bw(D1);

[lbl num] = bwlabel(D2);

figure, imshow(im)
hold on;
for cnt = 1:num
    s = regionprops(lbl, 'BoundingBox','Centroid');
    plot(s(cnt).Centroid(1),s(cnt).Centroid(2),'ro');
%     hold on
%     rectangle('position', s(cnt).BoundingBox,'EdgeColor','r','linewidth',2);
end
hold off