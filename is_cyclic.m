function [ is_cyclic ] = is_cyclic( C )
% This function checks if the code specified by the given codebook is a
% a cyclic code.

% ARGUMENTS
% Inputs:   - (2^k x n) codebook matrix C
% Outputs:  - a boolean, is_cyclic, indicating if the code is cyclic

% initialize to true -> will be set false if necessary
is_cyclic = true;

height = size(C, 1);

% loop through the codewords (assuming first row of codebook is a zero row)
for i = 2:height
    % for codeword i, test if the cyclic shift of that codeword exists
    % in the codebook (i.e. it is also a codeword)
    %
    shifted_codeword = circshift(C(i, :), [1 1]);
    shift_exists = false;
    
    % check shifter codeword i against all other codes in codebook
    for j = 1:height
        % check shifted version of codeword i against other codeword j
        if shifted_codeword == C(j, :)
            % shifted codeword has been found
            shift_exists = true;
            % end the innder loop -> shifted version of codeword i has
            % been found in C -> can now move to codeword i+1
            break;
        end
    end
    % if the shifted version of codeword i has not been found after the
    % the whole codebook has been searched -> the code can not be a cyclic 
    % code -> set is_cyclic to false, break outer loop and return
    if shift_exists == false
        is_cyclic = false;
        break;
    end
end

end

