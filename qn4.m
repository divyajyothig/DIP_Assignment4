% Ripple Transform

% x = x' + ax*sin(2pi*y'/Tx)
% y = y' + ay*sin(2pi*x'/Ty)
%%
clc;
clear all;
close all;

im = imread('cameraman.tif');
x = 1:size(im,1);
y = 1:size(im,2);

[p1,q1] = meshgrid(y,x);

% Equations for Ripple Transform
x_new = p1 + 10 * sin((2*pi*q1)/120);
y_new1 = q1 + 15 * sin((2*pi*p1)/200);

%Interpolating to generate the new image
new1 = interp2(p1,q1,double(im),x_new,y_new1);

figure,imshow(im,[]);
figure,imshow(new1,[]);