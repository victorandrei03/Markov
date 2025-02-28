function [G, c] = get_Jacobi_parameters(Link)
% In this function I take the parameters to apply the Jacobi method, G
% representing the Link matrix without the last 2 rows and 2 columns, and c
% the penultimate column in Link

  [rows, columns] = size(Link);
  rows = rows - 2;
  columns = columns - 2;
  G = sparse(rows, columns);
  c = sparse(rows, 1);
  for i = 1: rows
    for j = 1 : columns
      G(i, j) = Link(i, j);
    endfor
  endfor
  for i = 1 : rows
    c(i, 1) = Link(i, columns + 1);
  endfor
endfunction
