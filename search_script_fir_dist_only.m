% The same as search_script_fir, but coefficients achieving the largest 
% minimum distance aren't saved, in an effort for better speed

% specify input parameters
n = 8; % code length
k = 4; % dimension

% generate message book with given parameters
MB = gen_msg_book(k);

largest_min_hamming_dist = 0;

[b_mat, a_mat] = gen_coefficients(n-1, 1);

tic
% loop through coefficients
for i = 1:(2^n - 1)
    b_curr = b_mat(i, :);
    a_curr = 1;
        
    % generate code, codeword by codeword
    dmin = n;
    for j = 2:(2^k)
        % append zeros to messages to ensure filter output is of length n
        msg = cat(2, MB(j,:), zeros(1, (n - k)));
        % encode msg j in msg book and get codeword weight
        cw_weight = hamming_weight(gffilter(b_curr, a_curr, msg));
        % check hamming weight -> update minimum distance of code
        if cw_weight < dmin 
            dmin = cw_weight;
        end
        % if dmin <= largest min distance we already know this 
        % code won't improve record min distance -> don't have to 
        % check rest of msg book
        if dmin <= largest_min_hamming_dist
            break;
        end
    end

    % update largest minimum Hamming distance achieved
    if dmin > largest_min_hamming_dist
        largest_min_hamming_dist = dmin;
    end
end
toc
disp(['Largest minimum Hamming distance achieved for n = ', num2str(n), ' and k = ', num2str(k), ' is ', num2str(largest_min_hamming_dist)]);
