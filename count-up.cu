#include <thrust/device_vector.h> // Inclui a biblioteca para vetores na GPU (device)
#include <thrust/host_vector.h>   // Inclui a biblioteca para vetores na CPU (host)
#include <thrust/transform.h>     // Inclui a biblioteca para transformações
#include <thrust/iterator/constant_iterator.h>
#include <iostream>               // Biblioteca padrão para entrada e saída de dados
#include <thrust/count.h>

//import thrust functions


int main() {
    int n = 3112;
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

 
    
    thrust::transform(d_stocks2.begin(), d_stocks2.end(), d_stocks.begin(), d_daily_diff.begin(), thrust::minus<float>());
    int count = thrust::count_if(d_daily_diff.begin(), d_daily_diff.end(), thrust::placeholders::_1 > 0);

    //replace negative values with 0
    thrust::replace_if(d_daily_diff.begin(), d_daily_diff.end(), d_daily_diff.begin(), thrust::placeholders::_1 < 0, 0);

    //calculate average of positive values
    float average = thrust::reduce(d_daily_diff.begin(), d_daily_diff.end(), 0.0f, thrust::plus<float>()) / count;
    std::cout << "Average of positive differences: " << average << std::endl;
    std::cout << "Number of positive differences: " << count << std::endl;
    
}