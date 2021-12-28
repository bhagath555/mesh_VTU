function write_piece_vtu(p_data, c_data, pnts, conct, offset, types, file)

no_pnts = size(pnts,2);
no_cords = size(pnts,1);
no_cells = size(conct,2);

if size(p_data,2) ~= no_pnts
    error ('Points data size is not matching with points')
end


p_data_cmp = size(p_data,1);
c_data_cmp = size(c_data,1);


% -------------Strings of VTU format---------------------------
% The strings need not to be devided into these many. Here, I divided into
% many parts just to explain the commands and strucutre of vtu file.

str_init = cat (2, '\n<Piece NumberOfPoints="%d" NumberOfCells="%d"> \n');

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
str_cnct_c = '\n</DataArray> \n';

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

str_close_vtu = cat(2, '</Piece> \n');

%%  Writing into the file.

fprintf(file, str_init, no_pnts, no_cells);

fprintf(file, str_Pdata, 'Displacement', p_data_cmp);
fprintf(file, '%g ', p_data(:));
fprintf(file, str_Pdata_c);

fprintf(file, str_Cdata, 'Density', c_data_cmp);
fprintf(file, '%g ', c_data(:));
fprintf(file, str_Cdata_c);

% Writing Point information
fprintf(file, str_pnts, no_cords);
fprintf(file, '%g ', pnts(:));
fprintf(file, str_pnts_c);

% Writing Cell information - Connectivity
fprintf(file, str_cnct );
fprintf(file, '%d ', conct(:));
fprintf(file, str_cnct_c );

% Writing Cell Offset
fprintf(file, str_off );
fprintf(file, '%d ', offset(:));
fprintf(file, str_off_c );

% Writing Cell types
fprintf(file, str_types );
fprintf(file, '%d ', types(:));
fprintf(file, str_tpye_c );

fprintf(file, str_cell_c );
fprintf(file, str_close_vtu );

end