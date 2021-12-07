pnts = [0,5,10,0,5,10,0,5,10; 0 0 0  4 4 4 8 8 8; 0 0 0 0 0 0 0 0 0];
grid = [2,2];
Pdata = randn(3, size(pnts,2)); % Size is 2, number of points 
Cdata = randn(1,grid(1)*grid(2)); % Size is 1, number of cells
quad_vtu2D(pnts, grid, Pdata, Cdata, '../VTU_files/2DQuad.vtu')