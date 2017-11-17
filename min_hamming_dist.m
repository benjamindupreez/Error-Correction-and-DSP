function [ min_dist ] = min_hamming_dist( C, is_lin_block )
% This function calculates the minimum Hamming distance of a given codebook
% C. If the optional parameter is_lin_block_code is set to true, the
% function uses the following property of linear block codes:
% d_min(C) = min_w(C) to speed up the function execution time

% ARGUMENTS
% Inputs:   - codebook matrix C
%           - optional boolean is_lin_block specifying if C is a linear
%             block code
% Outputs:  - the minimum Hamming weight of C (integer) 

% check if the optional parameter was passed and set to true
if nargin == 2
    if is_lin_block == true
        min_dist = min_hamming_weight(C);
    end
else
    % get dimensions of the codebook C
    height = size(C, 1);
    width = size(C, 2);
    % initialise min to the largest possible value
    min_dist = width;
    
    % loop through codes
    for i = 1:height
        % for each code i, loop through all other codes j
        for j = 1:height
            % don't compare with self
            if i==j
                continue;
            end
            % get Hamming distance between code i and j
            curr_dist = hamming_dist(C(i,:), C(j,:));
            if curr_dist < min_dist
                min_dist = curr_dist;
            end
        end
    end
end


end

