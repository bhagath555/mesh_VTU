function [conct, offset, types] = topo_hexahedron(pnts, cells_x, cells_y, cells_z)

gx = cells_x;
gy = cells_y;
gz = cells_z;
no_cells  = gx*gy*gz; 

% Checking the relation between no. of points and grid shape.
if size(pnts,2) ~= (gx+1)*(gy+1)*(gz+1)
    error('Grid type is not matching with the no. of points');
end

% Calculating Cell connectivity data, (conectivity, offset, and types)
conct = zeros(8,no_cells);
offset = 8:8:8*no_cells;
types = 12*ones(no_cells,1);
% Construct cell connectivity array
cb = [0,1,gx+2,gx+1,(gx+1)*(gy+1), (gx+1)*(gy+1)+1, (gx+1)*(gy+1)+gx+2,(gx+1)*(gy+1)+gx+1];
cell_num = 1;
for k=1:gz
    for j=1:gy
        for i=1:gx
           conct(:,cell_num) = cb;
           cb = cb+1;
           cell_num = cell_num+1;
        end
        cb = cb+1;
    end
    cb = cb+gx+1;
end

end