function [Link] = get_Link_aux_matrix(Labyrinth)
% To implement this function, I have the same approach as when constructing the
% adjacency matrix, except that at the end I count how many elements equal to 1
% are on the respective line and divide each element by the respective counter.

  [m, n] = size(Labyrinth);
  rows = m * n + 2;
  columns = m * n + 2;
  display(rows);
  display(columns);
  Link_aux = sparse(rows, columns);
  Link_aux(columns - 1, columns - 1) = 1;
  Link_aux(columns, columns) = 1;
  for i = 1 : m
    for j = 1 : n
      element_bits = fliplr(bitget(Labyrinth(i, j), 1:4));
      if element_bits(1) == 0
        if i == 1
          Link_aux(j, columns - 1) = 1;
        else
          element_bits_top = fliplr(bitget(Labyrinth(i - 1, j), 1:4));
          if element_bits_top(2) == 0
            Link_aux(n * (i - 1) + j, n * (i - 2) + j) = 1;
            Link_aux(n * (i - 2) + j, n * (i - 1) + j) = 1;
          endif
        endif
      endif
      if element_bits(3) == 0
        if j == n
          Link_aux(i * n, columns) = 1;
        else
          element_bits_top = fliplr(bitget(Labyrinth(i, j + 1), 1:4));
            if element_bits_top(4) == 0
              Link_aux(n * (i - 1) + j, n * (i - 1) + j + 1) = 1;
              Link_aux(n * (i - 1) + j + 1, n * (i - 1) + j) = 1;
            endif
        endif
      endif
      if element_bits(2) == 0
        if i == m
          Link_aux(n * (i - 1) + j, columns - 1) = 1;
        endif
      endif
      if element_bits(4) == 0
        if j == 1
          Link_aux(n * (i - 1) + j, columns) = 1;
        endif
      endif
    endfor
  endfor
  Link = sparse(rows, columns);
  count = zeros(rows, 1);
  for i = 1 : rows
    for j = 1 : columns
      if(Link_aux(i, j) == 1)
      count(i, 1) += 1;
      endif
    endfor
  endfor
  for i = 1 : rows
    for j = 1 : columns
      Link(i, j) = Link_aux(i, j) / count(i, 1);
    endfor
  endfor
endfunction
