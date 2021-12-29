% This scripts generates the VTU file with Quad elements.
% Simple geometry data and some random dislacement and cell data is
% cosidered for working and visualization purpose.
pnts = [0 5 10 0 5 10 0 5 10; 0 0 0 4 4 4 8 8 8; 0 0 0 0 0 0 0 0 0];
gx = 2;
gy = 2;
Pdata = randn(3, size(pnts,2)); % Point Data (3, number of points)
Cdata = randn(1,gx*gy); % Cell Data (1, number of cells)
% The VTU file with above data will be store here.s
filename = '../VTU_files/2DQuad.vtu';
% Topology information
[conct, offset, types] = topo_quad(pnts, gx, gy);
write_VTU(p_data, c_data, pnts, conct, offset, types, filename)