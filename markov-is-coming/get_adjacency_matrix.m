function [Adj] = get_adjacency_matrix(Labyrinth)
% In this function I go through the entire maze matrix and in the code below
% each bit is represented as follows: b1 - the top wall, b2 - the bottom wall
%, b3 - the right wall, b4 - the left wall. Going through
% the matrix I check for each bit of the respective element the row or
% column towards the win/lose state. With the help of bit 3 I check the next
% element on the right, transforming it into a group of bits in
% which I will check if there is a wall to the left of it (b4) and if not
% I will insert its position in the adjoint. I also check if there is a wall
% above for the respective element, and I will insert the positions in the adjoint matrix
% . Therefore, through this algorithm I check each element of
% the matrix.

  [m, n] = size(Labyrinth);
  rows = m * n + 2;
  columns = m * n + 2;
  Adj = sparse(rows, columns);
  Adj(columns - 1, columns - 1) = 1;
  Adj(columns, columns) = 1;
  for i = 1 : m
    for j = 1 : n
      if Labyrinth(i, j) != 0
        element_bits = fliplr(bitget(Labyrinth(i, j), 1:4));
      else
        element_bits = zeros(1, 4);
      endif
      if element_bits(1) == 0
        if i == 1
          Adj((i - 1) * n + j, columns - 1) = 1;
        else
          element_bits_top = fliplr(bitget(Labyrinth(i - 1, j), 1:4));
          if element_bits_top(2) == 0
            Adj(n * (i - 1) + j, n * (i - 2) + j) = 1;
            Adj(n * (i - 2) + j, n * (i - 1) + j) = 1;
          endif
        endif
      endif
      if element_bits(3) == 0
        if j == n
          Adj(i * n, columns) = 1;
        else
          element_bits_top = fliplr(bitget(Labyrinth(i, j + 1), 1:4));
            if element_bits_top(4) == 0
              Adj(n * (i - 1) + j, n * (i - 1) + j + 1) = 1;
              Adj(n * (i - 1) + j + 1, n * (i - 1) + j) = 1;
            endif
        endif
      endif
      if element_bits(2) == 0
        if i == m
          Adj(n * (i - 1) + j, columns - 1) = 1;
        endif
      endif
      if element_bits(4) == 0
        if j == 1
          Adj(n * (i - 1) + j, columns) = 1;
        endif
      endif
    endfor
  endfor
endfunction
