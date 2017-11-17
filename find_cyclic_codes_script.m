% Given the order, n, of the polynomial x^n + 1, this function finds all
% the binary polynomials of order n-k that factorise it. All these polynomials 
% can be used as generator polynomials to generate cyclic (n,k) codes and, 
% in other words, any filter having their coefficients as its impulse response 
% up to the n'th sample will also generate a cyclic code

% polynomials are represented by their coefficients in the form:
% 1 + x + x^2 + x^3 + . . . + x^n, where n is the order

% Finally, the script then also constructs codes from all these cyclic 
% impulse responses using FIR filters and see what the best Hamming 
% distance achieved is

n = 7; % the order of the polynomial x^n + 1
k = 4; %k, the message length
factor_order = n - k; % the order of the desired generator polynomials

% empty matrix which will contain the answers as rows
cyclic_impulse_responses = zeros(1, n-k+1);

xn = cat(2, 1, cat(2, zeros(1, n-1), 1)); % the polynomial x^n+1

% all the possible answers are polynomials of order n-k, i.e. the
% coefficients are a vector of length n-k+1, with the last entry always
% equal to 1. use gen_coefficients and fliplr to generate this
[b, a] = gen_coefficients(1, n-k);
possibilities = fliplr(a);

% check which of 
% these polynomials divide x^n+1 and save them in answers
for j = 1:size(possibilities,1)
    
    [quot,remd] = gfdeconv(xn, possibilities(j,:));
    
    if remd == 0 % the polynomial divides x^n+1
        cyclic_impulse_responses = cat(1, cyclic_impulse_responses, possibilities(j,:));
    end
end
% delete zero row introduced by initialisation
cyclic_impulse_responses = cyclic_impulse_responses(2:end,:);

if(size(cyclic_impulse_responses,1) == 0)
    disp('No cyclic codes found.');
end

% find largest minimum Hamming distance achieved by one of the cyclic codes
% constructed from the impulse responses that were found
record_min_distance = 0;
msg_book = gen_msg_book(k);
record_coeffs = zeros(1, n); % each row in this matrix holds a b coefficients vector

for m = 1:size(cyclic_impulse_responses,1)
    C = gen_codebook(cyclic_impulse_responses(m,:), 1, msg_book, n);
    min_distance = min_hamming_dist(C, true);
    
    if min_distance > record_min_distance % record broken
        record_min_distance = min_distance;
        record_coeffs = cyclic_impulse_responses(m,:);
    elseif min_distance == record_min_distance % record tied
        record_coeffs = cat(1, record_coeffs, cyclic_impulse_responses(m,:));
    end
end
    
    
    




