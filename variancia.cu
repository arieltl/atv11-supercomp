#include <thrust/device_vector.h> // Inclui a biblioteca para vetores na GPU (device)
#include <thrust/host_vector.h>   // Inclui a biblioteca para vetores na CPU (host)
#include <thrust/transform.h>     // Inclui a biblioteca para transformações
#include <thrust/iterator/constant_iterator.h>
#include <iostream>               // Biblioteca padrão para entrada e saída de dados

//import thrust functions


int main() {
    int n = 3111;
    thrust::host_vector<float> h1(n);
    thrust::host_vector<float> h2(n);

    //read file format x,y
    for (int i = 0; i < 10; i++) {
        char comma;
        std::cin >> h1[i] >> comma >> h2[i];
    }

    //transfer data to device
    thrust::device_vector<float> d1 = h1;
    thrust::device_vector<float> d2 = h2;
     
     //calculate difference between vectors
    thrust::transform(d1.begin(), d1.end(), d2.begin(), d1.begin(), thrust::minus<float>());



  
    float meanf = thrust::reduce(d1.begin(), d1.end(), 0.0f, thrust::plus<float>()) / n;

    thrust::constant_iterator<float> mean(meanf);



    thrust::transform(d1.begin(), d1.end(), mean, d1.begin(), thrust::minus<float>());

    thrust::transform(d1.begin(), d1.end(), d1.begin(), d1.begin(), thrust::multiplies<float>());

    float variance = thrust::reduce(d1.begin(), d1.end(), 0.0f, thrust::plus<float>()) / n;
    std::cout << "Variance: " << variance << std::endl;
    
}