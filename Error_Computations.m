
function [psnr mse DFD FD] = Error_Computations(Reference ,Target, imgComp)

[row col] = size(Target);

err = 0;
imgPr = double(Reference);
imgT = double(Target);
imgComp = double(imgComp);

for i = 1:row
    for j = 1:col
        FD(i,j) = abs(imgPr(i,j) - imgT(i,j)); % Frame difference
        DFD(i,j) = abs(imgT(i,j) - imgComp(i,j)); %Displaced frame difference
        err = err + (imgT(i,j) - imgComp(i,j))^2;
    end
end
mse = err / (row*col); %Mean Square error
DFD = uint8(DFD);
FD = uint8(FD);

psnr = 20 * log10(255 /sqrt(mse)); %PSNR calculation