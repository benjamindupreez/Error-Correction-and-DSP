function [ M ] = gen_msg_book( k )
% This function generates a message book for a binary code with the
% given message length k. The full message book with all possible 2^k 
% binary messages is returned.

% ARGUMENTS
% Inputs:   - length of input messages k (integer)
% Outputs:  - (2^k x k) message book matrix M

% generate integer range from 0 to 2^k
nums = 0:(2^k-1);

% convert integers to binary vectors in GF(2)
M = de2bi(nums, k, 'left-msb');

end

