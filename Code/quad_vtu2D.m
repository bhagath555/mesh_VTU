function quad_vtu2D(pnts, grid, filename):

gx = grid(1);
gy = grid(2);

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

str_Cdata = cat (2, '<PointData>\n', ...
    '<DataArray type="Float64" Name="%s" format="ascii" NumberOfComponents="%d"> \n');
% Cell data closing command
str_Cdata_c = cat (2,'</DataArray> \n', ...
    '</CellData> \n');

% Point information
str_pnts = cat(2, '<Points> \n', ...
    '<DataArray type="Float64" NumberOfComponents="3"> \n');
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
fprintf (fid, str_init, no_pnts, no_cells);



fclose (fid);




end

