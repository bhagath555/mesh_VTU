function write_VTU(p_data, c_data, pnts, conct, offset, types, filename)

no_pnts = size(pnts,2);
no_cords = size(pnts,1);
no_cells = size(conct,2);

if size(p_data,2) ~= no_pnts
    error ('Points data size is not matching with points')
end


fid = fopen (filename, 'w');
if (fid < 0)
    error ('msh_to_vtu: could not open file %s', filename);
end

p_data_cmp = size(p_data,1);
c_data_cmp = size(c_data,1);


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

%%  Writing into the file.

fprintf(fid, str_init, no_pnts, no_cells);

fprintf(fid, str_Pdata, 'Displacement', p_data_cmp);
fprintf(fid, '%g ', p_data(:));
fprintf(fid, str_Pdata_c);

fprintf(fid, str_Cdata, 'Density', c_data_cmp);
fprintf(fid, '%g ', c_data(:));
fprintf(fid, str_Cdata_c);

% Writing Point information
fprintf(fid, str_pnts, no_cords);
fprintf(fid, '%g ', pnts(:));
fprintf(fid, str_pnts_c);

% Writing Cell information - Connectivity
fprintf(fid, str_cnct );
fprintf(fid, '%d ', conct(:));
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