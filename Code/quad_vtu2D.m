function quad_vtu2D(pnts, grid, Pdata, Cdata, filename)

gx = grid(1);
gy = grid(2);


no_cords = size(pnts,1);
no_pnts = size(pnts,2);

no_cells  = gx*gy; 

% ----------------Checking the conditions----------------------
% Checking the relation between no. of points and grid shape.
if no_pnts ~= (gx+1)*(gy+1)
    error('Grid type is not matching with the no. of points');
end
% File condition.
fid = fopen (filename, 'w');
if (fid < 0)
    error ('msh_to_vtu: could not open file %s', filename);
end

Pdata_cmp = size(Pdata,1);
Cdata_cmp = size(Cdata,1);

% Calculating Cell connectivity data, (conectivity, offset, and types)
cnnct = zeros(4,no_cells);
offset = 4:4:4*no_cells;
types = 9*ones(no_cells,1);

% Construct cell connectivity array
cnn_base = [0, gx+1, gx+2, 1];
cell_num = 1;
for i=1:gy
    for j=1:gx
       cnnct(:,cell_num) = cnn_base;
       cnn_base = cnn_base+1;
       cell_num = cell_num+1;
    end
    cnn_base = cnn_base+1;
end


% -------------Strings of VTU format---------------------------
% The strings need not to be devided into these many. Here, I divided into
% many parts just to explain the commands and strucutre of vtu file.

str_init = cat (2,'<?xml version="1.0"?> \n', ...
    '<VTKFile type="UnstructuredGrid" version="0.1"> \n', ...
    '<UnstructuredGrid> \n', ...
    '<Piece NumberOfPoints="%d" NumberOfCells="%d"> \n');

str_Pdata = cat (2, '<PointData>\n', ...
    '<DataArray type="Float64" Name="%s" format="ascii" NumberOfComponents="%d"> \n');
% Point data closing command
str_Pdata_c = cat(2, '</DataArray> \n', ...
    '</PointData> \n'); 

str_Cdata = cat (2, '<CellData>\n', ...
    '<DataArray type="Float64" Name="%s" format="ascii" NumberOfComponents="%d"> \n');
% Cell data closing command
str_Cdata_c = cat (2,'</DataArray> \n', ...
    '</CellData> \n');

% Point information
str_pnts = cat(2, '<Points> \n', ...
    '<DataArray type="Float64" NumberOfComponents="%d"> \n');
% Point information closing
str_pnts_c = cat (2, '\n', ...
    '</DataArray> \n', ...
    '</Points> \n');

% Cell information - Connectivity
str_cnct = cat (2, '<Cells> \n', ...
    '<DataArray type="Int32" Name="connectivity">\n');
% Connectivity closing
str_cnct_c = '\n </DataArray> \n';

% Cell Offset
str_off = '<DataArray type="Int32" Name="offsets"> \n';
% Offset closing
str_off_c = '</DataArray> \n';

% Cell types
str_types = '<DataArray type="Int32" Name="types"> \n';
% Cell type closing
str_tpye_c = '</DataArray>\n';

% Closing cell
str_cell_c =  '</Cells> \n';

str_close_vtu = cat(2, '</Piece> \n', ...
    '</UnstructuredGrid> \n', ...
    '</VTKFile> \n');

% Writing into the file.
fprintf(fid, str_init, no_pnts, no_cells);

fprintf(fid, str_Pdata, 'Displacement', Pdata_cmp);
fprintf(fid, '%g ', Pdata(:));
fprintf(fid, str_Pdata_c);

fprintf(fid, str_Cdata, 'Density', Cdata_cmp);
fprintf(fid, '%g ', Cdata(:));
fprintf(fid, str_Cdata_c);

% Writing Point information
fprintf(fid, str_pnts, no_cords);
fprintf(fid, '%g ', pnts(:));
fprintf(fid, str_pnts_c);

% Writing Cell information - Connectivity
fprintf(fid, str_cnct );
fprintf(fid, '%d ', cnnct(:));
fprintf(fid, str_cnct_c );

% Writing Cell Offset
fprintf(fid, str_off );
fprintf(fid, '%d ', offset(:));
fprintf(fid, str_off_c );

% Writing Cell types
fprintf(fid, str_types );
fprintf(fid, '%d ', types(:));
fprintf(fid, str_tpye_c );

fprintf(fid, str_cell_c );
fprintf(fid, str_close_vtu );

fclose (fid);

end

