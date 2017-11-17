function [ C ] = gen_non_causal_codebook( h, zero_pos, M, n )
%GEN_NON_CAUSAL_CODEBOOK Summary of this function goes here
%   Detailed explanation goes here

k = size(M, 2);

C = zeros(2^k, n);

for i = 1:2^k
C(i, :) = non_causal_filter(h, cat(2, M(i, :), zeros(1, n-k)), zero_pos);
end



end

