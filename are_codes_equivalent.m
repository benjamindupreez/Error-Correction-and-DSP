function [ are_equivalent ] = are_codes_equivalent( C1, C2 )
% This function checks if the two codes C1 and C2 are equivalent, i.e. if
% their codebooks contain the same set codewords, even if the codewords may
% be in a different order

% ARGUMENTS
% Inputs:   - code matrix C1
%           - codebook matrix C2
% Outputs:  - a boolean, are_equivalent, indicating if C1 and C2 are
%             equivalent codes

% assume false initially, change if otherwise
are_equivalent = false;

% throw error if dimensions are not the same
if size(C1) ~= size(C2)
   error('Error. The dimensions of the two codebooks must be equivalent');
% check if codebook matrices are equivalent after their rows are sorted
elseif isequal(sortrows(C1), sortrows(C2))
    are_equivalent = true;
end

end

