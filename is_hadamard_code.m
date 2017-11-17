function [ is_hadamard_code ] = is_hadamard_code( C )
% An Hadamard code is a linear block code with n = 2^k, dmin = 2^(k-1) and 
% ALL codewords in the codebook has weight = dmin

k = log2(size(C, 1));
n = size(C, 2);

% assume true for starters, will be set false if necessary
is_hadamard_code = true;

% check that n = 2^k
if n ~= 2^k
    is_hadamard_code = false;
% if it passed the first test check that all non-zero codewords have weight
% equals to dmin
else
    dmin = min_hamming_dist(C, true);
    % if it passed the first test check that dmin = 2^(k-1)
    if dmin ~= 2^(k-1)
       
    % if it passed the 2nd test check that all non-zero codewords have 
    % weight equal to dmin
    else
        for i=1:2^k
           curr_weight = hamming_weight(C(i,:));
           if curr_weight ~= 0 && curr_weight ~= dmin
             is_hadamard_code = false;  
           end
        end
    end
end
    

end

