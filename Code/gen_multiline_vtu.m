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

filename = 'multi-line.vtu';

file = fopen (filename, 'w');
init_piece_vtu(file)

for i=1:4
    pnts = matrix(:,:,i)*verts;
    % Number of cells 
    no_cells = size(pnts,2)-1;
    % Calculating Cell connectivity data, (conectivity, offset, and types)
    conct = zeros(2,no_cells);
    offset = 2:2:2*no_cells;
    types = 3*ones(no_cells,1);
    % Construct cell connectivity array
    el_cnct = [0,1];
    for j =1:no_cells
        conct(:,j) = (j-1)+el_cnct;
    end
    vtu_piece_writer(p_data, c_data, pnts, conct, offset, types, file)
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
gx = 3;
gy = 2;
no_cells  = gx*gy; 

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

p_data = 6*rand([3,(gx+1)*(gy+1)]);
c_data = 6*rand([1,no_cells]);

vtu_piece_writer(p_data, c_data, pnts, conct, offset, types, file)


%% Closing the file
close_piece_vtu(file)