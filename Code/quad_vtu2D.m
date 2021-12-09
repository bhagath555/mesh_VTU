function quad_vtu2D(pnts, grid, p_data, c_data, filename)

gx = grid(1);
gy = grid(2);
no_cells  = gx*gy; 

% Checking the relation between no. of points and grid shape.
if size(pnts,2) ~= (gx+1)*(gy+1)
    error('Grid type is not matching with the no. of points');
end

% Calculating Cell connectivity data, (conectivity, offset, and types)
conct = zeros(4,no_cells);
offset = 4:4:4*no_cells;
types = 9*ones(no_cells,1);
% Construct cell connectivity array
cnn_base = [0, gx+1, gx+2, 1];
cell_num = 1;
for i=1:gy
    for j=1:gx
       conct(:,cell_num) = cnn_base;
       cnn_base = cnn_base+1;
       cell_num = cell_num+1;
    end
    cnn_base = cnn_base+1;
end

write_VTU(p_data, c_data, pnts, conct, offset, types, filename)

end

