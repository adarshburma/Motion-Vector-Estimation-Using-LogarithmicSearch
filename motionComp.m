

function imgComp = motionComp(imgI, motionVect, mbSize)

[row col] = size(imgI);


% we start off from the top left of the image
% we will walk in steps of mbSize
% for every marcoblock that we look at we will read the motion vector
% and put that macroblock from refernce image in the compensated image

mbCount = 1;
for i = 1:mbSize:row-mbSize+1
    for j = 1:mbSize:col-mbSize+1
        
        % dy is row(vertical) index
        % dx is col(horizontal) index
        % this means we are scanning in order
        
        dx = motionVect(1,mbCount);
        dy = motionVect(2,mbCount);
        refBlkVer = i + dx;
        refBlkHor = j + dy;
        if ( refBlkVer < 0 || refBlkVer == 0)
           refBlkVer = i;
        end    
        if (refBlkHor < 0 || refBlkHor == 0)
            refBlkHor = j;
        end    
        imageComp(i:i+mbSize-1,j:j+mbSize-1) = imgI(refBlkVer:refBlkVer+mbSize-1, refBlkHor:refBlkHor+mbSize-1);
    
        mbCount = mbCount + 1;
    end
end

imgComp = imageComp;