#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>
#include <limits>
#include <cstdint>

using namespace std;

template <class ForwardIt, class BiFun>
void fillup(ForwardIt start, size_t n, ForwardIt out, BiFun f)
{

    int last_value(*start);
    for (auto it=start; n != 0; ++it, --n) {        
        // fill up the top
        *out = f(*it, last_value);
        last_value = *out;
        ++out;
    }

}

// Complete the fewestTowers function below.
long fewestTowers(vector<int> x, vector<int> y) {
    // Return the minimum number of towers that need to be constructed so that the condition is satisfied.
    int max_x = *max_element(x.begin(), x.end());
    int min_x = *min_element(x.begin(), x.end());

    vector<int> top_y( (max_x - min_x)+1, numeric_limits<int>::min());
    vector<int> bottom_y( (max_x - min_x)+1, numeric_limits<int>::max());
    
    auto it_x= x.begin();
    auto it_y= y.begin();
    while (it_x != x.end()) {
        int x_ = *it_x - min_x;

        top_y[x_]  = max(*it_y, top_y[x_]);
        bottom_y[x_] = min(*it_y, bottom_y[x_]);

        ++it_x;
        ++it_y;
    }

    size_t n_max_y = distance(top_y.begin(), max_element(top_y.begin(), top_y.end()));
    size_t n_min_y = distance(bottom_y.begin(), min_element(bottom_y.begin(), bottom_y.end()));
    

    fillup(top_y.begin(), n_max_y, top_y.begin(),  [] (int x, int y) {return max(x,y);});
    fillup(top_y.rbegin(), top_y.size() - n_max_y, top_y.rbegin(), [] (int x, int y) {return max(x,y);});

    fillup(bottom_y.begin(), n_min_y, bottom_y.begin(),  [] (int x, int y) {return min(x,y);});
    fillup(bottom_y.rbegin(), bottom_y.size() - n_min_y, bottom_y.rbegin(),  [] (int x, int y) {return min(x,y);});

    long acum(0);
    for (size_t i  =0; i!= top_y.size(); ++i) {
        acum += static_cast<long>(top_y[i]) - static_cast<long>(bottom_y[i]) + 1;
    }
    
    return acum - x.size();

}

int main()
{
    int N;
    cin >> N;
    vector<int> x; x.reserve(N);
    vector<int> y; y.reserve(N);
    copy_n(istream_iterator<int>(cin),N,back_inserter(x));
    copy_n(istream_iterator<int>(cin),N,back_inserter(y));

    cout << fewestTowers(x,y);
    

}