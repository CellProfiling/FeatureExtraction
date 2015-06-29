function Close(n) 
% The function close maximum multiple figures without closing any GUI figure
v=ishandle(1:200);
if nargin==0 %close all first 200
        close(find(v))
else % close if there are more than n
    if sum(v)>n
        close(find(v))
    end
    
end