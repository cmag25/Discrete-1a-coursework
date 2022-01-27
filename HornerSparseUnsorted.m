function [Total] = HornerSparseUnsorted(index,B,x)
%evaluates a polynomial p(x) given a list of (not necessarily ordered)
%indices and their corresponding coefficients as well as x itself
power1=Inf;
Total=0;
currentMax=0;
position=1;
position2=1;

if isempty(index) %for the case when index and B are empty (we can assume they are the same length)
    Total=zeros(size(x));
    return;
end

for j=1:length(index) %finds the initial largest element of "index" 
    if (index(j)>=currentMax) && (index(j)<power1) %checks if the current element is both greater than the current max and less than the previous power (in this case power1=Inf so this is always true)
        currentMax=index(j);
        position=j; 
    end
end
power1=currentMax; %sets power1 to the largest element found using the for loop

%%%%%main loop%%%%%

for i=1:length(index)
    currentMax=0;
    for j=1:length(index) %finds the largest element of "index" that hasn't already been used
        if (index(j)>=currentMax) && (index(j)<power1) %checks if the current element is both greater than the current max and less than the previous power
            currentMax=index(j);
            position2=j;
        end
    end
    power2=power1; %power2 becomes the current largest power
    power1=currentMax;  %power1 becomes the next largest power
    if size(B,3)==1 %if B doesn't contain matrices we select the "postion"th element of B otherwise we select the "position"th matrix
        coefficient=B(position); %match the postion of power1 to the corresponding element of B
    else
        coefficient=B(:,:,position);
    end
    xPower=FastPower(x,(power2-power1)); %main calculations
    Total=Total+(coefficient*eye(size(x)));
    Total=xPower*Total;
    position=position2; %the postion of the largest power moves down
end