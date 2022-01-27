function [Total] = HornerSparse(index,B,x)
%evulates a polynomial p(x) given a list of indices (index), a list of
%coefficents(B), and x
m=0;
Total=0;
if isempty(index) %for the case when index and B are empty (we can assume they are the same length)
    Total=zeros(size(x));
    return;
end
for k=length(index):-1:1
    if size(B,3)==1 %for when B is just one matrix or an array of integers
        m=B(k);
    else
        m=B(:,:,k);
    end
    if k-1>0
        power=index(k)-index(k-1);
    else
        power=index(k); %makes sure we dont select an invalid term of index (0th term causes an error)
    end
    xPower=FastPower(x,power); %we use the FastPower function from tickable 5 to calculate x^power quickly
    Total=Total+(m*eye(size(x)));
    Total=(xPower)*Total;
end

