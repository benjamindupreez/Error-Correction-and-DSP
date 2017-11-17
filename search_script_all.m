% specify input parameters
n = 7; % code length
k = 4; % dimension

% generate message book with given parameters
MB = gen_msg_book(k);

largest_min_hamming_dist = 0;

[b_mat, a_mat] = gen_coefficients(n-1, n-1);

tic
for i = 1:(2^n - 1)
    b_curr = b_mat(i, :);
    for j = 1:2^(n-1)
        a_curr = a_mat(j, :);
        % generate a code with the current coefficients
        C = gen_codebook(b_curr, a_curr, MB, n);
        G = get_g_matrix(b_curr, a_curr, n, k);
        %sys_G = make_g_systematic(G);
        dmin = min_hamming_dist(C, true);
        
        % update largest minimum Hamming dist achieved
        if dmin > largest_min_hamming_dist
            largest_min_hamming_dist = dmin;
            %record_G = G;
            %record_sys_G = sys_G;
            record_C = C;
            record_b = b_curr;
            record_a = a_curr;
        end
        
        
        disp(['____________ NEW (', num2str(n), ', ', num2str(k), ') CODE CREATED ____________']);
        disp(['Minium Hamming distance = ', num2str(dmin)]);
        disp(['Is cyclic (1 = true, 0 = false): ', num2str(is_cyclic(C))]);
        disp(['Is perfect code / reaches Hamming bound (1 = true, 0 = false): ', num2str(is_perfect_code(n, k, dmin))]);
        disp(' ');
        disp('Filter transfer function, H[z]:');
        filt(b_curr, a_curr)
        disp('Transfer function coefficients (b and then a):');
        disp(b_curr);
        disp(a_curr);
        if a_curr == cat(2, ones(1, 1), zeros(1, N-1))
            disp('This is a FIR filter');
        else
            disp('This is an IIR filter');
        end
        disp(' ');
        disp('Generator matrix:');
        disp(G);
        %disp('Systematic generator matrix:');
        %disp(sys_G);
        
    end
end
toc

disp(['____________ LARGEST MINIMUM HAMMING DISTANCE ACHIEVED for n = ', num2str(n), ' and k = ', num2str(k), ' ____________']);
disp('ACHIEVED BY THE FOLLOWING CODE: ');
disp(['Minimum Hamming distance = ', num2str(largest_min_hamming_dist)]);
disp(['Is cyclic (1 = true, 0 = false): ', num2str(is_cyclic(record_C))]);
disp(['Is perfect code / reaches Hamming bound (1 = true, 0 = false): ', num2str(is_perfect_code(n, k, largest_min_hamming_dist))]);
disp(['Reaches Griesmer bound (1 = true, 0 = false): ', num2str(achieves_griesmer_bound(n, k, largest_min_hamming_dist))]);

disp(' ');
disp('Filter transfer function, H[z]:');
filt(record_b, record_a)
disp('Transfer function coefficients (b and then a):');
disp(record_b);
disp(record_a);
if record_a == cat(2, ones(1, 1), zeros(1, N-1))
    disp('This is a FIR filter');
else
    disp('This is an IIR filter');
end
disp(' ');
disp('Generator matrix:');
record_G = get_g_matrix(record_b, record_a, n, k); 
disp(record_G)
disp('Systematic generator matrix:');
disp(make_g_systematic(record_G));
