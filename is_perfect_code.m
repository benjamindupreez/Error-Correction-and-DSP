function [ is_perfect_code ] = is_perfect_code( n, k, dmin )
% This function checks if the code specified by the given codebook achieves
% the Hamming bound

% ARGUMENTS
% Inputs:   - n, the code length
%           - k, the message length
%           - dmin, the minimum Hamming distance of the code
% Outputs:  - a boolean, is_perfect_code, indicating if the code achieves
%             the Hamming bound

% get code dimensions and distance

% get lhs of Hamming bound inequality
lhs = 2^k;

% get rhs of Hamming bound inequality
t = floor((dmin - 1)/2);
sum = 0;
for i = 0:t
    sum = sum + nchoosek(n, i);
end    
rhs = (2^n)/(sum);

% lhs <= rhs, if lhs == rhs -> the code reaches the Hamming bound
if lhs == rhs
    is_perfect_code = true;
else
    is_perfect_code = false;
end

end

