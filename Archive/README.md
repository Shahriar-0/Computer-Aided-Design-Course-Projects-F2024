# Computer Aided Design Projects

- [Computer Aided Design Projects](#computer-aided-design-projects)
  - [Introduction](#introduction)
  - [CA1: Permutation](#ca1-permutation)
  - [Midterm: ColParity](#midterm-colparity)
  - [CA2: Encoder](#ca2-encoder)
    - [ColParity](#colparity)
    - [Rotate](#rotate)
    - [Permute](#permute)
    - [Revaluate](#revaluate)
    - [AddRc](#addrc)

## Introduction

In all of the projects, a $5\times 5\times 64$ matrix is encoded to another $5\times 5\times 64$ matrix using different methods.  
The encodings are implemented completely in hardware.  
The $(i,\ j)$ indices for a matrix slice are as follows:

<table>
    <tr>
        <td>(3, 2)</td>
        <td>(4, 2)</td>
        <td>(0, 2)</td>
        <td>(1, 2)</td>
        <td>(2, 2)</td>
    </tr>
    <tr>
        <td>(3, 1)</td>
        <td>(4, 1)</td>
        <td>(0, 1)</td>
        <td>(1, 1)</td>
        <td>(2, 1)</td>
    </tr>
    <tr>
        <td>(3, 0)</td>
        <td>(4, 0)</td>
        <td>(0, 0)</td>
        <td>(1, 0)</td>
        <td>(2, 0)</td>
    </tr>
    <tr>
        <td>(3, 4)</td>
        <td>(4, 4)</td>
        <td>(0, 4)</td>
        <td>(1, 4)</td>
        <td>(2, 4)</td>
    </tr>
    <tr>
        <td>(3, 3)</td>
        <td>(4, 3)</td>
        <td>(0, 3)</td>
        <td>(1, 3)</td>
        <td>(2, 3)</td>
    </tr>
</table>

## CA1: Permutation

In this part, the encoding is done using the following formula:

$$\forall i,\ j \in [0,4]\ \forall k \in [0, 63]: a[i][j][k] = a[j][(2i+3j)\ \%\ 5][k]$$

This means that in each slice, the bits are mapped to a different location in the slice.

## Midterm: ColParity

In this part, the encoding is done using the following formula:

$$\forall i,\ j \in [0,4]\ \forall k \in [0, 63]: a[i][j][k] = a[i][j][k] \oplus a[(i-1)\ \%\ 5][0..4][k] \oplus a[(i+1)\ \%\ 5][0..4][(k+1)\ \%\ 64]$$

This means that each bit of the matrix becomes the XOR of itself, the bit's left column, and its right column in the previous slice.

## CA2: Encoder

Here, 5 different encodings are applied serially to the input 24 times.

### ColParity

This part is the same function implemented in [Midterm](#midterm-colparity).

### Rotate

The following formula is used for encoding:

$$\forall i,\ j \in [0,4]\ \forall k \in [0, 63]: a[i][j][k] = a[i][j][(k-\frac{(t+1)(t+2)}{2})\ \%\ 64]$$

The number $t$ starts from 0 and goes up to 23. On each increment, an $(x,\ y)$ pair is calculated using the following formula:

$$\begin{pmatrix} 0 & 1 \\ 2 & 3\end{pmatrix}^t\begin{pmatrix} 1 \\ 0\end{pmatrix} \mod 5 = \begin{pmatrix} x \\ y\end{pmatrix}$$

The $(x,\ y)$ pair shows which lane of the matrix should be shifted $\frac{(t+1)(t+2)}{2}$ times.

### Permute

This part is the same function implemented in [CA1](#ca1-permutation).

### Revaluate

The following formula is used for encoding:

$$\forall i,\ j \in [0,4]\ \forall k \in [0, 63]: a[i][j][k] = a[i][j][k] \oplus (\lnot a[(i+1)\ \%\ 5][j][k]\ \&\ a[(i+2)\ \%\ 5][j][k])$$

### AddRc

The following formula is used for encoding:

$$\forall k \in [0,\ 63]: a[0][0][k] = a[0][0][k] \oplus RC[t][k]$$

Where the $RC$ values are presented in the following table:

<table>
    <tr>
        <th>RC[0]</th>
        <th>RC[1]</th>
        <th>RC[2]</th>
        <th>RC[3]</th>
    </tr>
    <tr>
        <td>0x0000000000000001</td>
        <td>0x0000000000008082</td>
        <td>0x800000000000808A</td>
        <td>0x8000000080008000</td>
    </tr>
    <tr>
        <th>RC[4]</th>
        <th>RC[5]</th>
        <th>RC[6]</th>
        <th>RC[7]</th>
    </tr>
    <tr>
        <td>0x000000000000808B</td>
        <td>0x0000000080000001</td>
        <td>0x8000000080008081</td>
        <td>0x8000000000008009</td>
    </tr>
    <tr>
        <th>RC[8]</th>
        <th>RC[9]</th>
        <th>RC[10]</th>
        <th>RC[11]</th>
    </tr>
    <tr>
        <td>0x000000000000008A</td>
        <td>0x0000000000000088</td>
        <td>0x0000000080008009</td>
        <td>0x000000008000000A</td>
    </tr>
    <tr>
        <th>RC[12]</th>
        <th>RC[13]</th>
        <th>RC[14]</th>
        <th>RC[15]</th>
    </tr>
    <tr>
        <td>0x000000008000808B</td>
        <td>0x800000000000008B</td>
        <td>0x8000000000008089</td>
        <td>0x8000000000008003</td>
    </tr>
    <tr>
        <th>RC[16]</th>
        <th>RC[17]</th>
        <th>RC[18]</th>
        <th>RC[19]</th>
    </tr>
    <tr>
        <td>0x8000000000008002</td>
        <td>0x8000000000000080</td>
        <td>0x000000000000800A</td>
        <td>0x800000008000000A</td>
    </tr>
    <tr>
        <th>RC[20]</th>
        <th>RC[21]</th>
        <th>RC[22]</th>
        <th>RC[23]</th>
    </tr>
    <tr>
        <td>0x8000000080008081</td>
        <td>0x8000000000008080</td>
        <td>0x0000000080000001</td>
        <td>0x8000000080008008</td>
    </tr>
</table>

And $t$ is the iteration number where the function is being executed. (the encoder module executes the 5 functions 24 times)
