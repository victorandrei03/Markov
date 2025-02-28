function [Labyrinth] = parse_labyrinth(file_path)
% In this function, I first read the number of lines (m) and the number
% of columns (n) from the file using the fscanf function, and then I loop
% through the number of lines (m) with a for from 1 to read each line into the
% array with fscanf.

  fp = fopen(file_path, "r");
  dimensions = fscanf(fp, "%d", 2);
  m = dimensions(1);
  n = dimensions(2);
  Labyrinth = zeros(m, n);

  for i = 1:m
    Labyrinth(i, :) = fscanf(fp, "%d", n);
  endfor
  fclose(fp)
endfunction

