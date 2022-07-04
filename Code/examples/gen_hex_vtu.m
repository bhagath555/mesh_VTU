% Generating point coordinates
px = 10; py=10; pz=10;
pnts = zeros(3,px*py*pz);
el = 1;
for z=1:pz
    for y=1:py
        for x =1:px
            pnts(:,el) = [x,y,z]; 
            el = el+1;
        end
    end
end
% Cell information in each parametric direction.
cells_x = px-1;
cells_y = py-1;
cells_z = pz-1;
% Generating lopology information.
[conct, offset, types] = topo_hexahedron(pnts, cells_x, cells_y, cells_z);

p_data = rand(size(pnts));
c_data = rand(size(types'));

write_VTU(p_data, c_data, pnts, conct, offset, types, 'Hex20.vtu')