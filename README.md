# Markov is coming

## Problem Statement

After achieving excellent grades in his first-semester subjects (especially in programming and linear algebra), Mihai decided to challenge himself with an interesting problem for which he aims to find an efficient solution.

Being passionate about technology, he bought himself a small robot that he can program as he wishes. In his spare time, he also built a small maze, intending to test his robot.

Now, Mihai wants to place the robot somewhere in the maze and program it so that it chooses the best possible direction at each step to escape. The robot is considered to have escaped if it finds one of the designated exits of the maze.

Since Mihai is not yet familiar with advanced search algorithms (as they are taught only in the second year), he proposes to start with a simpler problem and then implement a basic algorithm as follows:

- Given a maze and a starting position, what is the probability that my robot will reach a winning zone if, at each step, it randomly chooses a movement direction among the available ones?
- Additionally, how could I use the previously determined probabilities to find a path for the robot through my maze more efficiently than exhaustive search?

## A Visual Explanation

![image](https://github.com/user-attachments/assets/dbf2b624-30d1-4cd4-8b9d-4481a2cb2222)

Let's consider the simple maze above, represented as a square matrix, where the robot's starting position is the top-left corner. We assume the starting point has coordinates (1,1). The robot will move at each step to a new cell it has not previously visited, being able to move one square up, down, left, or right, but it is not allowed to move diagonally.

For example, from the starting position, it will visit the cell at coordinates (2,1), then (3,1) and (4,1), and then it will choose between the two adjacent cells based on which one has the highest probability of reaching a winning exit.

The exits in this problem are of two types:

- **Winning exits:** Marked in green in the image above. These always overlap with the upper and lower borders of the maze. If the robot exits through one of these, it is considered to have won (winning probability = 1).
- **Losing exits:** Marked in red in the image above. These always overlap with the left and right borders of the maze. If the robot exits through one of these, it is considered to have lost (winning probability = 0).

Inside the maze, there can also be walls that prevent the robot from passing between two adjacent cells. For instance, in the figure above, the robot cannot move directly from (1,1) to (1,2). Thus, at any given moment, the robot will have at most four choices corresponding to the directions in which it can move, choosing randomly among them with equal probability.

## Theoretical References

To model this situation, we will use **probability chains**, known as **Markov Chains**. Markov Chains are widely used in probability theory, with applications in fields such as economics, reliability of dynamic systems, and artificial intelligence algorithms. Google PageRank is also a modified form of a Markov Chain.

![Markov Chain Illustration](markov_chain.png)

The basic data structure of a Markov Chain is a directed graph, where nodes represent states, and each edge represents a nonzero probability of transitioning from an initial state to a final state. For any given state, the sum of all transition probabilities must equal one:

\[ \sum_{j=1}^{n} p_{ij} = 1, \quad \forall i \in \{1, n\} \]

We can apply a similar idea to our problem. Each cell in the maze will be associated with a state, numbered from the top-left corner as shown below:

![Numbered Maze](numbered_maze.png)

Besides the states corresponding to the robot's position in the maze cells, we will also need two additional states:

- **WIN state:** The state where we consider the robot has won, from which it cannot exit anymore.
- **LOSE state:** The state where we consider the robot has lost.

With these states added to our directed graph, we obtain the following Markov Chain:

![Markov Chain Representation](markov_graph.png)

## Adjacency and Transition Matrices

For this Markov Chain (which, abstractly, represents a directed graph where each edge has a weight equal to the previously described probability), we need a concrete characterization (a way of storing it effectively). The adjacency matrix and transition matrix are commonly used representations.

## Linear System Formulation

A Markov Chain can also be represented as a system of linear equations. Given the probability vector \( p \), we can describe the transition probabilities as:

\[ p = Gp + c \]

This formulation allows us to solve the system iteratively using methods like the **Jacobi method**, ensuring convergence under specific conditions.

## Heuristic Search Algorithm

The probabilities calculated earlier suggest that states closer to a **WIN** state have a higher probability of winning. Based on this, we can implement a **greedy heuristic search algorithm** to guide the robot efficiently to an exit.

The algorithm follows these steps:

1. Start at the given position.
2. Move to the neighboring state with the highest probability of reaching the WIN state.
3. Repeat until the WIN state is reached or no moves are possible.

Here is an example of an optimal path found using this heuristic:

![Heuristic Path](heuristic_path.png)

## Labyrinth Encoding

To process the maze as input data, we use a **binary encoding scheme** inspired by the **Cohen-Sutherland algorithm** for line clipping.

Each cell in the maze is encoded as a 4-bit number representing walls in different directions:

- **Bit 3 (North)**: Wall above the cell.
- **Bit 2 (South)**: Wall below the cell.
- **Bit 1 (East)**: Wall to the right.
- **Bit 0 (West)**: Wall to the left.

Example representation:

![Wall Encoding](wall_encoding.png)

## Implementation Requirements

Based on the theoretical background, you need to implement the following functions in MATLAB:

- `parse_labyrinth(file_path)`: Reads and decodes a maze from a file.
- `get_adjacency_matrix(Labyrinth)`: Constructs the adjacency matrix.
- `get_link_matrix(Labyrinth)`: Computes the transition matrix.
- `get_Jacobi_parameters(Link)`: Prepares data for the Jacobi iterative solver.
- `perform_iterative(G, c, x0, tol, max_steps)`: Solves the linear system iteratively.
- `heuristic_greedy(start_position, probabilities, Adj)`: Finds an escape path using heuristic search.
- `decode_path(path, lines, cols)`: Converts the numerical path to grid coordinates.

All matrices should be stored in **sparse format** for efficiency.

---

This document provides the full problem statement with all images properly included. Let me know if anything needs adjustments!

