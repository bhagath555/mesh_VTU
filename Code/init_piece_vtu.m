function init_piece_vtu(file)

str_init = cat (2,'<?xml version="1.0"?> \n', ...
    '<VTKFile type="UnstructuredGrid" version="0.1"> \n', ...
    '<UnstructuredGrid> \n');

fprintf(file, str_init );

end