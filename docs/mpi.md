# MPI

MPI is used for distributed-memory parallel programming.

## Concepts

- **Rank**: process ID inside an MPI communicator.
- **Size**: number of MPI processes.
- **Communicator**: group of MPI processes that can communicate.
- **MPI_Reduce**: combines values to a root process.
- **MPI_Allreduce**: combines values and returns the result to every rank.

## Hello program

```bash
cd mpi
make
mpirun -np 4 ./hello_mpi
```

Example output:

```text
Hello from rank 0 of 4 on ...
Hello from rank 1 of 4 on ...
Hello from rank 2 of 4 on ...
Hello from rank 3 of 4 on ...
```

## PI calculation

```bash
mpirun -np 4 ./pi_mpi
```

Each rank computes a portion of the numerical integration and `MPI_Reduce` combines the partial sums.

## Multi-node execution

The MPI runtime must be installed consistently on the nodes. Test:

```bash
mpirun -np 4 --host cn1,cn2 ./hello_mpi
```

The exact launcher options depend on the MPI implementation and cluster configuration.
