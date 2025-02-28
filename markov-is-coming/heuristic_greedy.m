function [path] = heuristic_greedy(start_position, probabilities, adjacency_matrix)
% In the function below I implement the algorithm given in the homework requirement. Therefore,
% I start from the start_position and find all the unvisited neighbors
% and choose the one with the higher probability of winning.

  n = size(adjacency_matrix, 1);
  path = [start_position];
  visited = zeros(1, n);
  visited(start_position) = 1;

  while ~isempty(path)
    position = path(end);
    if adjacency_matrix(position, n - 1) == 1
      path = [path, n - 1];
      return;
    endif

    neigh = adjacency_matrix(position, :);
    unvisited_neighbours = [];
    for i = 1 : length(neigh)
      if neigh(i) != 0 && visited(i) != 1
        unvisited_neighbours(end + 1) = i;
      endif
    endfor
    if isempty(unvisited_neighbours)
      path(end) = [];
    else
      [~, index] = max(probabilities(unvisited_neighbours));
      neigh = unvisited_neighbours(index);
      visited(neigh) = 1;
      path = [path, neigh];
    endif
  endwhile
endfunction

