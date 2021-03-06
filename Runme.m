% First set of Images
Reference = imread('Reference.bmp');
Target = imread('Target.bmp');

% Second set of Images
Reference2 = imread('Reference2.bmp');
Target2 = imread('Target2.bmp');

%RGB to gray scale Conversion
Reference = rgb2gray(Reference);
Target = rgb2gray(Target);
Reference2 = rgb2gray(Reference2);
Target2 = rgb2gray(Target2);

% Motion vector Estimation on First set of images

[Motion_vectors_16 MB_centers_16] = LogarithmicSearch (Reference , Target , 16 , 7);
[Motion_vectors_8 MB_centers_8] = LogarithmicSearch (Reference , Target , 8 , 7);

% Motion vector Estimation on second set of images
[Motion_vectors2_16 MB_centers2_16] = LogarithmicSearch (Reference2 , Target2 , 16 , 7);
[Motion_vectors2_8 MB_centers2_8] = LogarithmicSearch (Reference2 , Target2 , 8 , 7);


% Motion Compensation for First set of images
imgComp_16 = motionComp(Reference, Motion_vectors_16, 16);
imgComp_8 = motionComp(Reference, Motion_vectors_8, 8);

% Motion Compensation for second set of images
imgComp2_16 = motionComp(Reference2, Motion_vectors2_16, 16);
imgComp2_8 = motionComp(Reference2, Motion_vectors2_8, 8);

% Error Computations DFD and FD for First set of images
[psnr_16 mse_16 DFD_16 FD_16] = Error_Computations(Reference,Target, imgComp_16);
[psnr_8 mse_8 DFD_8 FD_8] = Error_Computations(Reference,Target, imgComp_8);

% Error Computations DFD and FD for second set of images
[psnr2_16 mse2_16 DFD2_16 FD2_16] = Error_Computations(Reference2,Target2, imgComp2_16);
[psnr2_8 mse2_8 DFD2_8 FD2_8] = Error_Computations(Reference2,Target2, imgComp2_8);

% Display 

subplot(5,4,1);
imshow(Reference);
title('Reference image 1');

subplot(5,4,2);
imshow(Target);
title('Target image 1');

subplot(5,4,3);
imshow(Reference2);
title('Reference image 2');

subplot(5,4,4);
imshow(Target2);
title('Target image 2');

subplot(5,4,5);
imshow(imgComp_16);
title('Compensated image1 for 16 block size');

subplot(5,4,6);
imshow(imgComp_8);
title('Compensated image1 for 8 block size');

subplot(5,4,7);
imshow(imgComp2_16);
title('Compensated image2 for 16 block size');

subplot(5,4,8);
imshow(imgComp2_8);
title('Compensated image2 for 8 block size');

subplot(5,4,9);
imshow(DFD_16);
title('DFD image1 for 16 block size');

subplot(5,4,10);
quiver(Reference,imgComp_8);
imshow(DFD_8);
title('DFD image1 for 8 block size');

subplot(5,4,11);
imshow(DFD2_16);
title('DFD image2 for 16 block size');

subplot(5,4,12);
imshow(DFD2_8);
title('DFD image2 for 8 block size');

subplot(5,4,13);
imshow(FD_16);
title('FD image1 for 16 block size');

subplot(5,4,14);
imshow(FD_8);
title('FD image1 for 8 block size');

subplot(5,4,15);
imshow(FD2_16);
title('FD image2 for 16 block size');

subplot(5,4,16);
imshow(FD2_8);
title('FD image2 for 8 block size');

subplot(5,4,17);
imagesc(unique(MB_centers_16(1,:)+1),unique(Motion_vectors_16(1,:)),Target);  
hold on;    
quiver(MB_centers_16(1,:),Motion_vectors_16(1,:),MB_centers_16(2,:),Motion_vectors_16(2,:)); 
hold off;
title('Motion viz image1 MB size 16');

subplot(5,4,18);
imagesc(unique(MB_centers_8(1,:)+1),unique(Motion_vectors_8(1,:)),Target);  
hold on;    
quiver(MB_centers_8(1,:),Motion_vectors_8(1,:),MB_centers_8(2,:),Motion_vectors_8(2,:)); 
hold off;
title('Motion viz image1 MB size 8');

subplot(5,4,19);
imagesc(unique(MB_centers2_16(1,:)+1),unique(Motion_vectors2_16(1,:)),Target2);  
hold on;    
quiver(MB_centers2_16(1,:),Motion_vectors2_16(1,:),MB_centers2_16(2,:),Motion_vectors2_16(2,:)); 
hold off;
title('Motion viz image2 MB size 16');

subplot(5,4,20);
imagesc(unique(MB_centers2_8(1,:)+1),unique(Motion_vectors2_8(1,:)),Target2);  
hold on;    
quiver(MB_centers2_8(1,:),Motion_vectors2_8(1,:),MB_centers2_8(2,:),Motion_vectors2_8(2,:)); 
hold off;
title('Motion viz image2 MB size 8');


% Display MSE and PSNR calculations on Command Window:


sprintf('Image 1 8 MBsize MSE: %0.5f',mse_8)   
sprintf('Image 1 16 MBsize MSE: %0.5f',mse_16)
sprintf('Image 2 8 MBsize MSE: %0.5f',mse2_8)
sprintf('Image 2 16 MBsize MSE: %0.5f',mse2_16)
sprintf('Image 1 8 MBsize PSNR: %0.5f',psnr_8)
sprintf('Image 1 16 MBsize PSNR: %0.5f',psnr_16)
sprintf('Image 2 8 MBsize PSNR: %0.5f',psnr2_8)
sprintf('Image 2 16 MBsize PSNR: %0.5f',psnr2_16)








