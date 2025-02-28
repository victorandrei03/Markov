function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)
% In this function I use the Jacobi algorithm to find the vector x
% (the probability vector), the error and the number of steps, the error being
% the tolerance if the algorithm was successfully executed or 1.
% The number of steps is equal to the maximum number of steps minus how many times
% the while loop was executed.

  [n n] = size(G);
  err = 0;
  steps = max_steps;
  x = zeros(n,1);
  while steps > 0
    steps -= 1;
    x = G * x + c;
    if norm(x - x0) < tol
      err = 1;
      break;
    endif
    x0 = x;
  endwhile
  steps = max_steps - steps;
  err = tol;
endfunction

