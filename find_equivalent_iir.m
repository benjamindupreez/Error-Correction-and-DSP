function [ b_iir, a_iir ] = find_equivalent_iir( b_fir, n )
% Given a certain FIR filter, this function returns an all pole IIR filter structure
% with a impulse response matching the FIR filter's impulse response up to
% element n

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

for i = 2:n
    % if the equation is satisfied with the new a and b coefficients = 0,
    % let it be, otherwise choose one = 1, the other one stays = 0
    if mod(b_iir(i) + sum(rev_impulse_response(n-i+2:n).*a_iir(2:i)), 2) ~= impulse_response(i)
       if rev_impulse_response(n) ~= 0
        a_iir(i) = 1;
       else
        b_iir(i) = 1;
       end
    end
end

end