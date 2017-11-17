function [ iir_filters ] = find_all_equivalent_iirs( b_fir, n )
% Given a certain FIR filter with b coefficients b_fir, this function 
% returns all IIR filter structures with an impulse response matching the 
% FIR filter's impulse response up to element n

% ARGUMENTS
% Inputs:   - b_fir, the FIR coefficients of the filter who's impulse
%             response needs to be matched
%           - n, the code length, i.e. the point to where the impulse
%             response represented by b_fir needs to be matched
% Outputs:  - irr_filters, a 2^n-1 matrix holding all matching IIR filters found

% each row in this matrix holds an a and b coefficients vector pair
iir_filters = zeros(1, 2*n); 

if n >= size(b_fir, 2)
    impulse_response = cat(2, b_fir, zeros(1, n - size(b_fir, 2)));
else
    impulse_response = b_fir(1:n);
end    
    
rev_impulse_response = fliplr(impulse_response);

a_iir = zeros(1, n);
b_iir = zeros(1, n);
% a_0 is always = 1
a_iir(1) = 1;
% b_0 is = the first impulse response element
b_iir(1) = impulse_response(1);

determine_new_row_b_and_a(b_iir, a_iir, 2);
% this function is used recursively to work the solutions matrix from top
% to bottom. each possible new answer is followed up in it's own recursive
% function call. in the end all the matching irr filter coefficients are
% stored in a matrix
    function determine_new_row_b_and_a(b_iir, a_iir, i)
        % if i = n+1 then recursion needs to stop and the result saved
        if i == n + 1
            iir_filters = cat(1, iir_filters, cat(2, b_iir, a_iir));            
        else
        
            % first check if the equation is satisfied when a and b = 0
             if mod(b_iir(i) + sum(rev_impulse_response(n-i+2:n).*a_iir(2:i)), 2) == impulse_response(i)
                 % if true, check if h_0 is = 0
                 if rev_impulse_response(n) == 0
                     % we can now satisfy the equation by setting a = 0 or 1
                     % and setting b = 0 (only b influences the result since a is multiplied with 0)

                     determine_new_row_b_and_a(b_iir, a_iir, i+1); % b = 0, a = 0
                     
                     a_iir(i) = 1;
                     determine_new_row_b_and_a(b_iir, a_iir, i+1); % b = 0, a = 1
                 else
                     % we can now satisfy the equation by setting a = b 
                     %(i.e. a = b = 0 or a = b = 1)
                     
                     determine_new_row_b_and_a(b_iir, a_iir, i+1); % b = 0, a = 0
                     
                     b_iir(i) = 1;
                     a_iir(i) = 1;
                     determine_new_row_b_and_a(b_iir, a_iir, i+1); % b = 1, a = 1
                 end
             else
                 % if false, check if h_0 is = 0
                 if rev_impulse_response(n) == 0
                     % we can now satisfy the equation by setting a = 0 or 1
                     % and setting b = 1 (only b influences the result since a is multiplied with 0)
                     
                    b_iir(i) = 1;
                    
                    determine_new_row_b_and_a(b_iir, a_iir, i+1); % b = 1, a = 0
                     
                    a_iir(i) = 1;
                    determine_new_row_b_and_a(b_iir, a_iir, i+1); % b = 1, a = 1

                 else
                     % we can now satisfy the equation by setting a != b 
                     %(i.e. a = 0, b = 1 or a = 1, b = 0)
                     
                    b_iir(i) = 1;
                    
                    determine_new_row_b_and_a(b_iir, a_iir, i+1); % b = 1, a = 0
                     
                    b_iir(i) = 0;
                    a_iir(i) = 1;
                    determine_new_row_b_and_a(b_iir, a_iir, i+1); % b = 0, a = 1                  

                 end             
             end
         
        end
    end
iir_filters = iir_filters(2:end,:); % remove zero row at the top
end

