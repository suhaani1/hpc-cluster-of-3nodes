#include <mpi.h>
#include <omp.h>
#include <iostream>
#include <vector>

int main(int argc, char** argv)
{
    MPI_Init(&argc, &argv);

    int rank = 0;
    int size = 0;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    const long long total = 100000000;
    const long long local_n = total / size;
    const long long remainder = total % size;
    const long long n = local_n + (rank < remainder ? 1 : 0);

    std::vector<double> values(n, 1.0);

    double local_sum = 0.0;

    #pragma omp parallel for reduction(+:local_sum)
    for (long long i = 0; i < n; ++i)
    {
        local_sum += values[i];
    }

    double global_sum = 0.0;

    MPI_Allreduce(
        &local_sum,
        &global_sum,
        1,
        MPI_DOUBLE,
        MPI_SUM,
        MPI_COMM_WORLD
    );

    if (rank == 0)
    {
        std::cout << "Global sum = " << global_sum << std::endl;
        std::cout << "MPI ranks = " << size << std::endl;
        std::cout << "OpenMP threads per rank = " << omp_get_max_threads() << std::endl;
    }

    MPI_Finalize();
    return 0;
}
