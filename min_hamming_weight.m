function [ min_weight ] = min_hamming_weight( C )
% This function finds the minium Hamming weight of code C, i.e. the
% non-zero row in C with the smallest Hamming weight

% ARGUMENTS
% Inputs:   - codebook matrix C
% Outputs:  - the minimum Hamming weight of C (integer) 

height = size(C, 1);
width = size(C, 2);
% initialise min_weight to the largest possible value it can be
min_weight = width;

% loop through rows
for i = 1:height
    % find hamming weight of current row
    curr_weight = hamming_weight(C(i, :));
    % if hamming weight of the current non-zero row is smaller than the 
    % previous minimum record -> update minimum
    if curr_weight < min_weight && curr_weight ~= 0
        min_weight = hamming_weight(C(i, :));
    end
end

end

