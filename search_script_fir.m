% Don't extract generator matrices or do cyclicity checks etc except for
% record codes. Only check for FIR filter coefficients (impulse responses)

% specify input parameters
n = 10; % code length
k = 7; % dimension

% generate message book with given parameters
MB = gen_msg_book(k);

largest_min_hamming_dist = 0;

% each row in this matrix holds a b coefficients vector
record_coeffs = zeros(1, n); 

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
        if cw_weight < dmin%(cw_weight ~= 0)&&(cw_weight < dmin) 
            dmin = cw_weight;
        end
        % if dmin < largest min distance we already know this 
        % code won't achieve record min distance -> don't have to 
        % check rest of msg book
        if dmin < largest_min_hamming_dist
            break;
        end
    end

    % update largest minimum Hamming distance achieved
    if dmin > largest_min_hamming_dist
        record_coeffs = b_curr;
        largest_min_hamming_dist = dmin;
    % another code also achieved this Hamming distance
    elseif dmin == largest_min_hamming_dist
        record_coeffs = cat(1, record_coeffs, b_curr);%cat(2, b_curr, a_curr));
    end
end
toc
disp(['Largest minimum Hamming distance achieved for n = ', num2str(n), ' and k = ', num2str(k), ' is ', num2str(largest_min_hamming_dist)]);
disp(['The number of FIR filters that achieve this Hamming distance: ', num2str(size(record_coeffs, 1))]);
disp(' ');
disp('The first one found is shown below:');
disp(['Is perfect code / reaches Hamming bound (1 = true, 0 = false): ', num2str(is_perfect_code(n, k, largest_min_hamming_dist))]);
disp(['Reaches Griesmer bound (1 = true, 0 = false): ', num2str(achieves_griesmer_bound(n, k, largest_min_hamming_dist))]);
disp(' ');
disp('Transfer function coefficients (b and then a):');
disp(record_coeffs(1,:));
disp('Filter transfer function, H[z]:');
filt(record_coeffs(1,:), 1)
disp(' ');
disp('Generator matrix:');
record_G = get_g_matrix(record_coeffs(1,:), 1, n, k); 
disp(record_G)
disp('Systematic generator matrix:');
disp(make_g_systematic(record_G));
