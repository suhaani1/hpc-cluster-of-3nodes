#include <mpi.h>
#include <iostream>

int main(int argc, char** argv)
{
    MPI_Init(&argc, &argv);

    int rank = 0;
    int size = 0;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    const long long steps = 100000000;
    const double step = 1.0 / static_cast<double>(steps);

    long long start = rank * steps / size;
    long long end = (rank + 1) * steps / size;

    double local_sum = 0.0;

    for (long long i = start; i < end; ++i)
    {
        double x = (i + 0.5) * step;
        local_sum += 4.0 / (1.0 + x * x);
    }

    double global_sum = 0.0;
    MPI_Reduce(&local_sum, &global_sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

    if (rank == 0)
    {
        double pi = global_sum * step;
        std::cout << "Estimated PI = " << pi << std::endl;
    }

    MPI_Finalize();
    return 0;
}
