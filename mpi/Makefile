CXX=mpicxx
CXXFLAGS=-O2

all: hello_mpi pi_mpi hybrid_sum

hello_mpi: hello_mpi.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

pi_mpi: pi_mpi.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

hybrid_sum: hybrid_sum.cpp
	$(CXX) $(CXXFLAGS) -fopenmp $< -o $@

clean:
	rm -f hello_mpi pi_mpi hybrid_sum
