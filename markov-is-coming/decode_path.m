function [decoded_path] = decode_path (path, lines, cols)
% For this function I traverse the line vector path, transforming with the help of the formulas below
% the given number (element path(1, i)) into its position in
% the initial matrix, and then inserting it into decoded_path.

  number_elem_paths = numel(path) - 1;
  decoded_path = zeros(number_elem_paths, 2);
  for i = 1 : number_elem_paths
    x = path(1, i);
    decoded_path(i, 1) = ceil(x / cols);
    decoded_path(i, 2) = mod(x - 1, cols) + 1;
  endfor
endfunction

