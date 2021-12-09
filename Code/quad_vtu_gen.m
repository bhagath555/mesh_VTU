% This scripts generates the VTU file with Quad elements.
% Simple geometry data and some random dislacement and cell data is
% cosidered for working and visualization purpose.
pnts = [0,5,10,0,5,10,0,5,10; 0 0 0  4 4 4 8 8 8; 0 0 0 0 0 0 0 0 0];
grid = [2,2];
Pdata = randn(3, size(pnts,2)); % Point Data (3, number of points)
Cdata = randn(1,grid(1)*grid(2)); % Cell Data (1, number of cells)
% The VTU file with above data will be saved in above_directory/VTU_files
quad_vtu2D(pnts, grid, Pdata, Cdata, '../VTU_files/2DQuad.vtu')