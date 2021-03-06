function [ D , dv ] = find_tracks_shifting( Y , X , test_center , test_size , max_shift )
%[ D , best_dist , dv ] = find_tracks_shifting( Y , X , test_center , test_size , max_shift ) 
%  search the best fit point between two audio track.
%  It try to move the vector X such that the distance between X and Y is
%  minimized.
%  args:
%  Y, X: the two vectors [samples by channels]
%  test_center: the center of the tested area.
%  test_size: the size of the tested area (the tested area is 
%               test_center - test_size ... test_center + test_size ) 
%  max_shift: absolute maximal predicted shift 
%
%  Returns:
%  D: the shift of X respect to Y expressed in samples 
%  dv: a [2*max_shift+1 by 2] vector that store the tested shift and the
%       computed distance (this vector do NOT represents a real euclidean
%       distance) 
%  see also: shift_track


c = test_center ;
s = test_size ;
m = max_shift ;

if s <= 10000
    tsz = s ;
else
    tsz = 10001 ;
end

indx = floor ( 2*s*rand( 1 , tsz ) ) - s ;
r = c + indx ; 

D = -m ;
best_dist = realmax('double') ;

dv = zeros(2*m+1,2) ;

for i=-m:m   
   d = distance( Y(r,:) , X(r+i,:) ) ;
   
   if d < best_dist 
       D = i ;
       best_dist = d ;
   end
   
   dv(i+m+1,:) = [i d] ;
end

    function d = distance( x , y )
        d = mean ( sqrt( sum( ( x - y ).^2 ) ) ) ;
    end

end

