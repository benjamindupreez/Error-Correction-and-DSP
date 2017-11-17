function [ C ] = gen_codebook_non_causal( h, zero_pos, MB, n )
% This function generates the codebook of a code by encoding the given
% message book with the non causal filter defined by the given impulse response.
% The given input length should be = k, output length = n

% ARGUMENTS
% Inputs:   - row vectors for impulse response h
%           - zero_pos the position of t=0 in the impulse response
%           - (2^k x k) message book matrix message_book
%           - length of output codes n (integer)
% Outputs:  - (2^k x n) codebook matrix C

% get the value of k
k = size(MB, 2);

% throw error if k > n
if k>n
   error('Error. Codeword length, n, may not be shorter than message length, k');
end

% generate empty matrix for codebook
C = zeros(2^k, n);

% append zeros to messages to ensure filter output is of length n
MB = cat(2, MB, zeros(2^k, (n - k)));

% encode message book by filtering each row and save in codebook
for i = 1:(2^k)
    C(i,:) = non_causal_filter(h, MB(i,:), zero_pos);
end


end