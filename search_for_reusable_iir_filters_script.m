% Strategy: first find all the FIR filters achieving optimal codes using
% exactly the same method as in search_script_fir. Then use the function
% find_all_iir_filters to find all the corresponding IIR filters. 
% Do this multiple times, keeping k fixed and varying n and checking if one
% one IIR filter is every present

% specify input parameters
n_max = 12; % maximum code length to consider before terminating the search
k = 2; % dimension

% generate message book with given parameters
MB = gen_msg_book(k);

% each row in this matrix holds a b coefficients vector
record_coeffs = zeros(1, k); 

% \\\\\\\\\\\ execute the search algorithm for different code lengths \\\\\
for n = k:n_max
    
    largest_min_hamming_dist = 0;
    
    % save record_coeffs of previous search
    prev_coeffs = record_coeffs;
    % clear record_coeffs
    record_coeffs = zeros(1, n); 

    [b_mat, a_mat] = gen_coefficients(n-1, 1);

    % \\\\\\\\\\\\ find fir filters for k and current n \\\\\\\\\\\
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
    
    % check if any of the new found optimal FIRs are extended versions of
    % previous optimal FIR filters, i.e. they new filter matches the impulse 
    % respons of the old up to sample n-1
    % keep these rows and discard all the others
    if n ~= k % don't check the first row
        
        % get the indices of the rows in the two matrices where they match up to
        % sample n - 1
        [ia, ib] = ismember(record_coeffs(:, 1:n-1), prev_coeffs, 'rows');
        % get those rows out of record coeffs
        record_coeffs = record_coeffs(ia, :);
       
        
        % if no such rows are found terminate the search -> we already
        % know no IIR filters exist common to all optimal codes over the given
        % range
        if size(record_coeffs, 1) == 0
            break;
        end  
    end
    
end

% if record_coeffs still contain something, the IIR filters that represent
% this FIR filter will produce an optimal code for over the entire range of n
% with k specified
if size(record_coeffs, 1) ~= 0
    disp([num2str(size(record_coeffs, 1)), ' repeating impulse response pattern has been found over the specified range. Its equivalent IIR filter structures are saved in super_iirs']);
    super_iir_filters = find_all_equivalent_iirs(record_coeffs(1,:), size(record_coeffs, 2));
else
    disp('No results sorry!');
end

