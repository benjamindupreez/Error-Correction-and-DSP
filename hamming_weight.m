function [ weight ] = hamming_weight( a )
% This function finds the Hamming weight of a binary vector a and returns 
% the result as an integer
 
% ARGUMENTS
% Inputs:   - row vector a
% Outputs:  - the Hamming weight of a (integer) 

weight = sum(a == 1);

end

