% To export the multiline information into vtu, Here I have considered the
% sysnthotic data. any other kind of data also can be visualized with this
% approach.

verts = [0.225,0.515,0.98,1.8,3.4,5.25;
                   0,    0,   0,  0,  0,   0;
                1.13, 2.05,2.93,3.6,3.4,   0];
% Four lines are considered for the visualization. Here are their 
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

% Choosing directory and filename.
filename = '../../VTU_files/multi_line.vtu';

file = fopen (filename, 'w');
piece_vtu_init(file)

for i=1:4
    pnts = matrix(:,:,i)*verts;
    % Generate topology information of points information.
    % In evert loop, the defined points set in rotating with the help of 
    % differen matrix. So, multiple lines are being writen into the file.
    [conct, offset, types] = topo_line(pnts);
    write_piece_vtu(p_data, c_data, pnts, conct, offset, types, file)
end

%% Closing the file
piece_vtu_close(file)