#include <mpi.h>
#include <iostream>
#include <string>
#include <unistd.h>

int main(int argc, char** argv)
{
    MPI_Init(&argc, &argv);

    int rank = 0;
    int size = 0;
    char hostname[256];

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    gethostname(hostname, sizeof(hostname));

    std::cout
        << "Hello from rank " << rank
        << " of " << size
        << " on " << hostname
        << std::endl;

    MPI_Finalize();
    return 0;
}
