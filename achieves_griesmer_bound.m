function [ achieves_griesmer_bound ] = achieves_griesmer_bound( n, k, dmin )
% This function checks if the code specified by the given codebook achieves
% the Griesmer bound

% ARGUMENTS
% Inputs:   - n, the code length
%           - k, the message length
%           - dmin, the minimum Hamming distance of the code
% Outputs:  - a boolean, achieves_griesmer_bound, indicating if the code achieves
%             the Griesmer bound

% get lhs of Griesmer bound inequality
lhs = n;

% get rhs of Griesmer bound inequality
sum = 0;
for i = 0:(k-1)
    sum = sum + ceil(dmin/(2^i));
end    
rhs = sum;

% lhs <= rhs, if lhs == rhs -> the code reaches the Griesemer bound
if lhs == rhs
    achieves_griesmer_bound = true;
else
    achieves_griesmer_bound = false;
end

end

