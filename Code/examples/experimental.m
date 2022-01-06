% It is creative extension of the gen_multiline script.
% To export the multiline information into vtu, Here I have considered the
% sysnthotic data. any other kind of data also can be visualized with this
% approach.

verts = [0.225,0.515,0.98,1.8,3.4,5.25;
             0,    0,   0,  0,  0,   0;
          1.13, 2.05,2.93,3.6,3.4,   0];
% Four lines are considered for the visualization. Here are theri
% respective matrices to transform the above vertices.
matrix(:,:,1) = [1,0,0;
                 0,1,0;
                 0,0,1];
matrix(:,:,2) = [0,1,0;
                 1,0,0;
                 0,0,1];
matrix(:,:,3) = [-1,0,0;
                  0,1,0;
                  0,0,1];
matrix(:,:,4) = [0,1,0;
                -1,0,0;
                0,0,1];
p_data = [1,2,3,4,5,6;1,2,3,4,5,6;1,2,3,4,5,6];
c_data = [1,2,3,4,5,6];

filename = '../../VTU_files/experimental.vtu';

file = fopen (filename, 'w');
piece_vtu_init(file)

for i=1:4
    pnts = matrix(:,:,i)*verts;
    % Generate topology information of points information
    [conct, offset, types] = topo_line(pnts);
    write_piece_vtu(p_data, c_data, pnts, conct, offset, types, file)
end

%% Writing the quad geometry.
pnts = [-0.4,-1,1;
         0.7,-0.7,1;
         1.4,0.75,1;
         2.6,2.3,1;
         -0.8,-0.8,1;
         0,0,1.7;
         0.6,0.6,1.4;
         2,2,1.3;
         -1,-0.4,1;
         -0.7,0.7,1;
         0.75,1.4,1;
         2.3,2.6,1];

pnts = pnts';
% Number of cells in each direction
gx = 3;
gy = 2;
% Generating topology information
[conct, offset, types] = topo_quad(pnts, gx, gy);
% Random point and cell data
p_data = 6*rand([3,(gx+1)*(gy+1)]);
c_data = 6*rand([1,gx*gy]);

write_piece_vtu(p_data, c_data, pnts, conct, offset, types, file)


%% Closing the file
piece_vtu_close(file)