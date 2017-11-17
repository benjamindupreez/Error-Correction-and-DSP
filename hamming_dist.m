function [ dist ] = hamming_dist( a, b )
% This function finds the Hamming distance between binary vectors a and b
% of equal length and returns the result as an integer

% ARGUMENTS
% Inputs:   - row vectors a, b of equal length
% Outputs:  - the minimum Hamming distance between a and b (integer) 

% throw error if a and b is not of equal length
if size(a, 2) ~= size(b, 2)
   error('Error. Vectors a and b must be of equal length.');
end

% for binary codes d(a, b) = w(a + b) -> use this property
% a + b
diff = gfadd(a, b);
% count number of ones in result, i.e. w(a + b)
dist = hamming_weight(diff);

end