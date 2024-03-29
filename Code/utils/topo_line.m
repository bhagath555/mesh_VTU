function [conct, offset, types] = topo_line(pnts)

no_cells = size(pnts,2)-1;

% Calculating Cell connectivity data, (conectivity, offset, and types)
conct = zeros(2,no_cells);
offset = 2:2:2*no_cells;
types = 3*ones(no_cells,1);

% Construct cell connectivity array
el_cnct = [0,1];
for i =1:no_cells
    conct(:,i) = (i-1)+el_cnct;
end