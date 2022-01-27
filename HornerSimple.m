function [Total] = HornerSimple(A,x)
%evaluates a polynomial p(x) given coefficient list A and a given x
Total=0;
m=0;
if isempty(A)==1 %for the case when A is empty
    Total=zeros(size(x)); 
    return;
end
if size(A,3)>1 %sets the length of the for-loop
    Length=length(A); %for when A is some "pages" of matrices
elseif size(A,1)>1 %for when A is just one matrix, Length is set to one so the for loop doesn't cause an error
    Length=1;
else
    Length=length(A); %for when A is an array of integers
end

%%%%%%%%%%%%%%%%%

for i=Length:-1:1 %we work from the inside of the horner scheme outwards so our indexing is reversed
    if size(A,1)==1 %if A is a set of integers
        m=A(i)*eye(size(x)); 
    else
        m=A(:,:,i); %if A is an array of matices the ith matrix is selected
    end
    Total=m+(x*Total);   
end

