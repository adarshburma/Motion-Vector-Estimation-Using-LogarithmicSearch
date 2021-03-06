function [Motion_vectors,MB_centers] = LogarithmicSearch (Reference , Target , MBsize , p)

[row col] = size(Reference);

Motion_vectors = zeros(2,(row/MBsize)*(col/MBsize));
MB_centers = zeros(2,(row/MBsize)*(col/MBsize));
costs = ones(3, 3) * 111111;

Reference = double(Reference);
Target = double(Target);


mbCount = 1; % to keep track of the macro block count for the motion vector 

for i = 1:MBsize:row-MBsize+1
    for j = 1:MBsize:col-MBsize+1
        
% start from the top left pixel of each macro block        
        x = i + (MBsize/2);
        y = j + (MBsize/2);
        
        MB_centers(1,mbCount)= x; 
        MB_centers(2,mbCount)= y;
%calculating max levels based on search parameter and max step size
%calculation based on levels

        levels = floor(log10(p+1)/log10(2));  
        stepmax = 2^(levels - 1);
        stepsize = stepmax;
        
        
%calculating center at very first and skipping this in while loop
              
     costs(2,2) = costFuncMAD(Reference(i:i+MBsize-1,j:j+MBsize-1), ...
                                    Target(i:i+MBsize-1,j:j+MBsize-1),MBsize);
               
        
                                
% to continue step search until stepsize becomes < 1

    while( stepsize >= 1)   
        for m = -stepsize : stepsize : stepsize
            for n = -stepsize : stepsize : stepsize
                dispX = x + m;
                dispY = y + n;
                
%checking if macroblock around displaced coordinates goes out of image
%boundaries if so skip that iteration

                if ( dispX < 1 || dispX+MBsize-1 > row || dispY < 1 || dispY+MBsize > col)
                        continue;
                end
                
% Added 2 to map -1 to 1 , 0 to 2 , 1 to 3 since we can't have negetive
% indices

                costsx = m/stepsize + 2;
                costsy = n/stepsize + 2;
                
%skipping center calulation
                
                if (costsx == 2 && costsy == 2)
                        continue
                end
                
%Calculating the cost for displaced X , Y

                costs(costsx , costsy) = costFuncMAD(Reference(i:i+MBsize-1 , j:j+MBsize-1)...
                ,Target(dispX:dispX+MBsize-1 , dispY:dispY+MBsize-1),MBsize);
                
            end
        end
        
%Updating minimum cost 
        
        [dx,dy] = minCost(costs);
        
 %Assigning the coordinates with minimum cost or MAD as new center   
 
        x = x + (dx - 2) * stepsize;
        y = y + (dy - 2) * stepsize;
 
% Updating the center cost to minimum cost
        costs(2 , 2) = costs(dx , dy);
        stepsize = stepsize / 2;
        
    end
    
        Motion_vectors(1,mbCount) = x - (i+(MBsize/2));    % row co-ordinate for the vector
        Motion_vectors(2,mbCount) = y - (j+(MBsize/2));    % col co-ordinate for the vector            
        mbCount = mbCount + 1; % Incrementing Macro Block count
        costs = ones(3,3) * 111111; %Resetting costs for next level of search
    end
end

