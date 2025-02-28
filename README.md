# Markov

## 1.1 Problem Statement

After achieving excellent grades in his first-semester courses (especially in programming and linear algebra), Mihai decided to spend his time on an interesting problem, aiming to find the most efficient solution.

Being passionate about technology, he bought a small robot that he can program as he wishes. In his free time, he also built a small maze to test the robot.

Now, Mihai wants to place the robot somewhere in the maze and program it to choose, at each step, the best direction to escape. The robot is considered to have escaped if it finds one of the designated exits of the maze.

Since Mihai is not yet familiar with advanced search algorithms (which are taught in the second year), he decides to start with a simpler problem and implement a basic algorithm: Given a maze and a starting position, what is the probability that the robot will reach a winning area if it randomly chooses a direction to move at each step? Additionally, how can the probabilities determined earlier be used to find a more efficient path for the robot through the maze, avoiding exhaustive search?

## 1.2 Visual Explanation

Consider the following simple maze, represented as a square matrix, where the robot starts at the top-left corner. The starting position has coordinates (1, 1). At each step, the robot can move to a new cell in the maze that it hasn't visited before, moving one cell up, down, left, or right, but not diagonally.

For example, from the starting position, the robot will visit the cell at coordinates (2, 1), then the cells at (3, 1) and (4, 1), and then choose between the two adjacent cells based on the probability of reaching a winning exit.

There are two types of exits in the maze:

- **Winning exits**: These are marked in green and are always located at the top or bottom boundaries of the maze. If the robot exits through one of these, it wins (the probability of winning is 1).
- **Losing exits**: These are marked in red and are always located at the left or right boundaries of the maze. If the robot exits through one of these, it loses (the probability of winning is 0).

Inside the maze, there may also be walls that prevent the robot from moving between two adjacent cells. For example, in the figure above, the robot cannot move directly from cell (1, 1) to cell (1, 2). At any given time, the robot has up to 4 possible directions to move, and it can choose any of them with equal probability.

## 1.3 Theoretical Background

To model the situation, we will use **Markov chains**, which are particularly useful in probability theory and have applications in fields such as economics, reliability of dynamic systems, and artificial intelligence algorithms. **Google PageRank** is also a modified form of a Markov chain.

The basic data structure in Markov chains is a directed graph, where nodes represent states, and each edge between two states represents a non-zero probability of transitioning from the initial state to the final state. For any state, the sum of all transition probabilities is equal to 1. Mathematically, this can be represented as:

\[
\sum_{j=1}^{n} p_{ij} = 1, \quad \forall i \in 1, n
\]

We can apply a similar idea to our problem. We will associate each cell in the maze with a state and number the states starting from the top-left corner, as shown in the figure below.

In addition to the states corresponding to the robot's position in the maze, we will need two additional states:

- **WIN state**: This is the state where we can consider that we have won, and from which we cannot exit.
- **LOSE state**: This represents the state where we can consider that we have lost.

Once these are added to our directed graph, we obtain the following Markov chain:

For this Markov chain (which, abstractly, represents a directed graph where each edge has a certain weight equal to the probability described above), we need a concrete representation (i.e., a way to store it) that will help us effectively retain the chain. In the following sections, we will present some possible representations.

### 1.3.1 Adjacency Matrix

The adjacency matrix of a directed graph, similar to the concept of an adjacency matrix for an undirected graph, can be defined by the following relation:

\[
A = (A_{ij})_{i,j \in 1,n} \in \{0, 1\}^{n \times n}, \quad \text{where} \quad A_{ij} = 
\begin{cases}
1, & \text{if there is a transition from state } i \text{ to state } j \\
0, & \text{otherwise}
\end{cases}
\]

In the case of the graph in Figure 4, represented by 11 states (9 states corresponding to the maze cells and 2 additional states, WIN and LOSE, in that order), the adjacency matrix \( A \) of the graph is in \(\{0, 1\}^{11 \times 11}\) and has the following form:

\[
A = \begin{bmatrix}
0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 1 & 0 \\
0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 1 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1
\end{bmatrix}
\]

### 1.3.2 Link Matrix

The link matrix represents a more powerful form of the adjacency matrix, being very similar to it—the only difference is the meaning of the elements that populate it. In the case of the link matrix, the elements are the transition probabilities from one state to another in the Markov chain. Using the notation \( p_{ij} \) introduced earlier (Equation 1), it is defined as:

\[
L = (p_{ij})_{i,j \in 1,n} \in [0, 1]^{n \times n} \quad \text{where} \quad L_{ij} = 
\begin{cases}
p_{ij}, & 0 < p_{ij} \leq 1 \\
0, & \text{otherwise}
\end{cases}
\]

For the example in Figure 4, the link matrix is as follows:

\[
L = \begin{bmatrix}
0 & 0 & 0 & \frac{1}{2} & 0 & 0 & 0 & 0 & 0 & \frac{1}{2} & 0 \\
0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & \frac{1}{3} & 0 & 0 & 0 & \frac{1}{3} & 0 & 0 & 0 & 0 & 0 \\
\frac{1}{3} & 0 & 0 & 0 & \frac{1}{3} & 0 & \frac{1}{3} & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & \frac{1}{2} & 0 & \frac{1}{2} & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & \frac{1}{3} & 0 & \frac{1}{3} & 0 & 0 & 0 & \frac{1}{3} & 0 & 0 \\
0 & 0 & 0 & \frac{1}{3} & 0 & 0 & 0 & \frac{1}{3} & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & \frac{1}{2} & 0 & \frac{1}{2} & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & \frac{1}{3} & 0 & \frac{1}{3} & 0 & 0 & 0 \\
1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1
\end{bmatrix}
\]

### 1.3.3 System of Linear Equations

In addition to the previous approaches, we can remember the Markov chain as a formulation that lends itself to another type of problem: solving a system of linear equations.

Specifically, consider a vector \( p \in \mathbb{R}^{m \times n} \) representing the probabilities of winning for each cell in the maze, where \( m, n \in \mathbb{N}^* \) are the dimensions of the maze. For example, in the case of Figure 5, \( p \in \mathbb{R}^9 \). This vector is populated according to the state numbering described earlier.

Let's experiment with the case where the robot is in state 1. It can perform the following valid transitions/moves through the maze:

- It can move to state 4 with a probability of \( \frac{1}{2} \).
- It can move to the WIN state and win, also with a probability of \( \frac{1}{2} \).

Thus, state 1 will be characterized by the following equation:

\[
p_1 = \frac{1}{2} \cdot p_4 + \frac{1}{2} \cdot p_{\text{WIN}}, \quad \text{but} \quad p_{\text{WIN}} = 1 \implies p_1 = \frac{1}{2} \cdot p_4 + \frac{1}{2}
\]

Similarly, equations can be written for all states:

\[
\begin{cases}
p_1 = \frac{1}{2} \cdot p_4 + \frac{1}{2} \\
p_2 = p_3 \\
p_3 = \frac{1}{3} \cdot p_2 + \frac{1}{3} \cdot p_6 \\
p_4 = \frac{1}{3} \cdot p_1 + \frac{1}{3} \cdot p_5 + \frac{1}{3} \cdot p_7 \\
p_5 = \frac{1}{2} \cdot p_4 + \frac{1}{2} \cdot p_6 \\
p_6 = \frac{1}{3} \cdot p_3 + \frac{1}{3} \cdot p_5 + \frac{1}{3} \cdot p_9 \\
p_7 = \frac{1}{3} \cdot p_4 + \frac{1}{3} \cdot p_8 + \frac{1}{3} \\
p_8 = \frac{1}{2} \cdot p_7 + \frac{1}{2} \cdot p_9 \\
p_9 = \frac{1}{3} \cdot p_6 + \frac{1}{3} \cdot p_8
\end{cases}
\]

We can write this system in matrix form:

\[
\begin{bmatrix}
p_1 \\
p_2 \\
p_3 \\
p_4 \\
p_5 \\
p_6 \\
p_7 \\
p_8 \\
p_9
\end{bmatrix}
=
\begin{bmatrix}
0 & 0 & 0 & \frac{1}{2} & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & \frac{1}{3} & 0 & 0 & 0 & \frac{1}{3} & 0 & 0 & 0 \\
\frac{1}{3} & 0 & 0 & 0 & \frac{1}{3} & 0 & \frac{1}{3} & 0 & 0 \\
0 & 0 & 0 & \frac{1}{2} & 0 & \frac{1}{2} & 0 & 0 & 0 \\
0 & 0 & \frac{1}{3} & 0 & \frac{1}{3} & 0 & 0 & 0 & \frac{1}{3} \\
0 & 0 & 0 & \frac{1}{3} & 0 & 0 & 0 & \frac{1}{3} & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & \frac{1}{2} & 0 & \frac{1}{2} \\
0 & 0 & 0 & 0 & 0 & \frac{1}{3} & 0 & \frac{1}{3} & 0
\end{bmatrix}
\cdot
\begin{bmatrix}
p_1 \\
p_2 \\
p_3 \\
p_4 \\
p_5 \\
p_6 \\
p_7 \\
p_8 \\
p_9
\end{bmatrix}
+
\begin{bmatrix}
\frac{1}{2} \\
0 \\
0 \\
0 \\
0 \\
0 \\
\frac{1}{3} \\
0 \\
0
\end{bmatrix}
\]

In the system above, the vector of free terms (highlighted in blue) comes from those elements that were initially linear combinations of \( p_{\text{WIN}} \).

We have done all this processing in Equation 2 to be able to write the following product:

\[
p = Gp + c
\]

This form is perfectly suited to the Jacobi iterative method, where we identify \( G \) and \( c \) as the iteration matrix and vector, respectively. Therefore, we will opt for this iterative method to solve the system. In our particular case (Figure 5), the spectral radius of matrix \( G \) is \( \rho(G) \approx 0.85192 \), which means that Jacobi will converge.

For the curious, the solution is:

\[
\begin{cases}
p_1 \approx 0.84615 \\
p_2 \approx 0.15385 \\
p_3 \approx 0.15385 \\
p_4 \approx 0.69231 \\
p_5 \approx 0.50000 \\
p_6 \approx 0.30769 \\
p_7 \approx 0.73077 \\
p_8 \approx 0.50000 \\
p_9 \approx 0.26923
\end{cases}
\]

### 1.3.4 Heuristic Search Algorithm

The results above reflect an obvious intuition: states that are "closer" to the **WIN state** have a higher probability of winning, while those closer to the **LOSE state** have a lower probability. This is why we could think of a heuristic search algorithm that would help the robot reach a winning state from the initial position more efficiently than an exhaustive search.

A heuristic search algorithm is an algorithm that does not provide an optimal solution (in our case, a minimal path) for all possible cases, but has the advantage of being very fast compared to classical exhaustive search algorithms.

We will use a simple greedy algorithm based on DFS, with the following pseudocode:

```pseudocode
procedure HEURISTIC_GREEDY(start_position, probabilities, adjacency_matrix)
    path ← [start_position]
    visited[start_position] ← True
    while path is not empty do
        position ← top() / last element of the path vector
        if position is the WIN state then
            return path
        if position has no unvisited neighbours then
            erase position from the end of the path
        neigh ← the unvisited neighbour (with greatest probability to reach WIN) of the current position
        visited[neigh] ← True
        path ← [path, neigh]
    return path (since there is no path to the WIN state)
In the figure below, we highlight the path that the robot will choose, considering the probabilities calculated earlier (we start from state/cell 2 in this example).

1.3.5 Maze Encoding
To process the maze as input data, a condensed representation of the maze is needed. Mihai was inspired by an algorithm he found in another context, computer graphics, called the Cohen-Sutherland algorithm.

The idea borrowed from the original algorithm is to binary encode the walls that separate spatially adjacent cells: our maze can be stored as a matrix with 
m
×
n
m×n entries, integers represented on 4 bits of the form 
b
3
b
2
b
1
b
0
b 
3
​
 b 
2
​
 b 
1
​
 b 
0
​
 , where each active bit (set to 1) represents a possible movement direction blocked by a wall in the maze. In our case, we adopt the following encoding:

Bit 
b
3
b 
3
​
  set to 1 indicates a wall to the north of the cell.

Bit 
b
2
b 
2
​
  set to 1 indicates a wall to the south of the cell.

Bit 
b
1
b 
1
​
  set to 1 indicates a wall to the east of the cell.

Bit 
b
0
b 
0
​
  set to 1 indicates a wall to the west of the cell.

In the case of our maze, the encoding would be:

It is very important to note that walls are bidirectional (i.e., although a random encoding would allow unidirectional transitions between states, we will exclusively treat the case of walls that block transitions in both directions between any adjacent states).

1.4 Requirements
After going through the theoretical material provided earlier, you are ready to implement the following functions in Matlab:

function [labyrinth] = parse_labyrinth(file_path)

The parse_labyrinth function will receive a relative path to a text file containing the encoded representation of the maze, as described in the theory section.

The input file format will be as follows:

Copy
m n
l_11 l_12 l_13 ... l_1n
l_21 l_22 l_23 ... l_2n
l_31 l_32 l_33 ... l_3n
...
l_m1 l_m2 l_m3 ... l_mn
function [Adj] = get_adjacency_matrix(Labyrinth)

The get_adjacency_matrix function will receive the encoded matrix resulting from the previous step and return the adjacency matrix of the graph/Markov chain.

function [Link] = get_link_matrix(Labyrinth)

The get_link_matrix function will receive the encoded matrix of a valid maze and return the link matrix associated with the given maze.

function [G, c] = get_Jacobi_parameters(Link)

The get_Jacobi_parameters function will receive the link matrix obtained earlier and return the iteration matrix and vector for the Jacobi method.

function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)

The perform_iterative function will receive the iteration matrix and vector, an initial approximation for the system's solution, a tolerance (maximum acceptable relative error for the approximate solution between two consecutive steps), and a maximum number of steps for the algorithm's execution.

function [path] = heuristic_greedy(start_position, probabilities, Adj)

The heuristic_greedy function will receive a starting position (an index of a cell/state in the range 
1
,
m
×
n
1,m×n), the extended probability vector (including the two probabilities for the WIN and LOSE states), and the adjacency matrix of the Markov chain. It will then return a valid path to the WIN state. It is guaranteed that the maze (and implicitly, the associated graph) is connected, so there will always be a valid winning path.

function [decoded_path] = decode_path(path, lines, cols)

The decode_path function will receive a valid path (as a column vector) and the dimensions of the maze and return a vector of pairs (a matrix with two columns), each pair representing the row and column of the cell with the given encoding.

1.4.1 Restrictions and Clarifications
Before you start working, it would be good to note that:

The maze is not necessarily square (the number of columns does not have to match the number of rows).

It is guaranteed that the maze is connected and that there is always a path to the WIN state and the LOSE state.

Note that the adjacency and link matrices are large but sparse. It is MANDATORY to store these matrices and derived matrices (such as the iteration matrix or iteration vector) as sparse matrices. Octave offers the possibility of storing sparse matrices in a much more efficient way than the conventional one, namely by storing the non-zero elements and their positions. There are also specialized functions for working with sparse matrices, which we encourage you to discover here.

For all functions in this task, the use of the dlmread function is prohibited (due to incompatibility of results that may occur between different versions of GNU Octave). Use other parsing methods in this case.
