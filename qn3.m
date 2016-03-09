clc;
clear all;
close all;

im = imread('cameraman.tif');
im = im2double(im);
J = imnoise(im,'gaussian',0,0.002);
% Variance = 0.002

figure, imshow(im); title('Original Image');
figure, imshow(J); title('After addition of noise');

%%
% Wavelet Transform for obtaining the subbands
%%

[LL,LH,HL,HH]=dwt2(J,'haar'); 
figure, subplot(2,2,1);imshow(LL,[]);title('LL band of image');
subplot(2,2,2);imshow(LH,[]);title('LH band of image');
subplot(2,2,3);imshow(HL,[]);title('HL band of image');
subplot(2,2,4);imshow(HH,[]);title('HH band of image');

%%
%%
% $$ \sigma ^{2} = [(median\left | Y_{ij} \right |)/0.06745]^{2} $$
%%
% $$ T = \sigma \sqrt{2\log M} $$
%%
% Perform multiscale decomposition on the image corrupted by Gaussian noise. 
%%
% For each subband (except the low pass residual), applying the threshold T
% and then using the Soft-thresholding method to the noisy coefficients to 
% get the noiseless wavelet coefficients 
%%
% Finally taking the inverse wavelet transform of the resultant image 
% obtained in step 2) in order to obtain the denoised
% image 
%%
sig1 = (median(median(abs(HH)))/0.06745)^2;
sig2 = (median(median(abs(LH)))/0.06745)^2;
sig3 = (median(median(abs(HL)))/0.06745)^2;

thr1 = sqrt(sig1*2*log(length(im)));
thr2 = sqrt(sig2*2*log(length(im)));
thr3 = sqrt(sig3*2*log(length(im)));

ytsoft1 = wthresh(HH,'s',thr1);
ytsoft2 = wthresh(LH,'s',thr2);
ytsoft3 = wthresh(HL,'s',thr3);

X = idwt2(LL,ytsoft2,ytsoft3,ytsoft1,'db3');
figure, imshow(J); title('Noisy Image');
figure, imshow(X); title('Denoised Image');