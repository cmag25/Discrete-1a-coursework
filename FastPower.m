function [p] = FastPower(A,n)
%FROM THE TICKABLES
%calculates A^n=p recursively where A is a matrix and n is a non-negative integer
if n>=0 && n==floor(n) %checks that n is a natural number
    if n==0  %for the case n=0, sets p to the identity matrix
        p=eye(size(A));
    elseif n==2*floor(n/2) %even numbers
        p=FastPower(A*A,n/2);
    else %odd numbers
        p=FastPower(A*A,((n-1)/2));
        p=p*A;
    end
else
    error("n must either be a natural number or zero")
end

