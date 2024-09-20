#include <thrust/device_vector.h> // Inclui a biblioteca para vetores na GPU (device)
#include <thrust/host_vector.h>   // Inclui a biblioteca para vetores na CPU (host)
#include <thrust/transform.h>     // Inclui a biblioteca para transformações
#include <thrust/iterator/constant_iterator.h>
#include <iostream>               // Biblioteca padrão para entrada e saída de dados

//import thrust functions


int main() {
    int n = 3111;
    thrust::host_vector<float> h_stocks(n);

    //read cin
    for (int i = 0; i < n; i++) {
        std::cin >> h_stocks[i];
    }

    //send all but last element to gpu
    thrust::device_vector<float> d_stocks(h_stocks.begin(), h_stocks.end() - 1);
    //send all but first element to gpu
    thrust::device_vector<float> d_stocks2(h_stocks.begin() + 1, h_stocks.end());

    //calculate daily difference
    thrust::device_vector<float> d_daily_diff(n - 1);
    thrust::transform(d_stocks.begin(), d_stocks.end(), d_stocks2.begin(), d_daily_diff.begin(), thrust::minus<float>());
    
}