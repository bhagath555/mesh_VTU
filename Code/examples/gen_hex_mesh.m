px = 5; py=3; pz=4;
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

cells_x = px-1;
cells_y = py-1;
cells_z = pz-1;
[conct, offset, types] = topo_hexahedron(pnts, cells_x, cells_y, cells_z);

p_data = rand(size(pnts));
c_data = rand(size(types'));

write_VTU(p_data, c_data, pnts, conct, offset, types, '../VTU_files/Hex.vtu')