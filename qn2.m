clc;
clear all;
close all;

imagefiles = dir('*.jpg');      
nfiles = length(imagefiles);

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   images{ii} = currentimage;
   imbw{ii} = im2bw(currentimage);
   [L{ii} n(ii)] = bwlabel(imbw{ii});
end

for i = 1 : nfiles
    bw{i} = bwconvhull(1 - imbw{i});
    e(i) = bweuler(imbw{i});
%     cd{i} = bw{i} & ~(1 - imbw{i});
end

a = 1:nfiles;
for i = 1 : nfiles
    if e(i) == 0
        S = 'Veerbhadrasan';
        out1 = [cellstr(S) num2cell(i)];
        ind = a(a~=i);
        a = ind;
    elseif e(i) == 3
        S = 'Vrikhsasana';
        out2 = [cellstr(S) num2cell(i)];
        ind = a(a~=i);
    end
end

for i = 1 : length(ind)
    j = ind(i);
    [label num] = bwlabel(bw{j});
    stat  = regionprops(label,'Centroid','Area','PixelIdxList');
    areas(i) = stat.Area;
    index(i) = j;
end

[max_val idx] = max(areas);
out3 = ['Trikonasana' num2cell(index(idx))];
indx = ind(ind~=index(idx));
out4 = ['Ustrasana' num2cell(index(indx))];
e
final_out = [out1; out2; out3; out4]

figure, imshow(images{2}); title({'Veerbhadrasan'})
figure, imshow(images{3}); title({'Vrikhsasana'})
figure, imshow(images{4}); title({'Trikonasana'})
figure, imshow(images{1}); title({'Ustrasana'})