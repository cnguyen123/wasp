function [x_close,y_close,index,Max] = find_intersection_x_y(x, y, ref, prev_index)

xr = ref(:,1);
yr = ref(:,2);

dist = 1000;
j = 1;
Max = length(xr);

for i = max(prev_index - 10,1):min(Max, prev_index + 10)
    r_error = sqrt((x-xr(i))^2+(y-yr(i))^2);
    if(r_error < dist)
            dist = r_error;
            j=i;
    end
end

index = j;

x_close = xr(index);
y_close = yr(index);



end