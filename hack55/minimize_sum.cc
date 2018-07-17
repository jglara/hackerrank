#include <iostream>
#include <iterator>
#include <algorithm>
#include <vector>

using namespace std;

int main()
{
    
    int N;
    cin >> N;

    vector<int> l; l.reserve(N);
    vector<int> r; r.reserve(N);

    copy_n(istream_iterator<int>(cin), N, back_inserter(l));
    copy_n(istream_iterator<int>(cin), N, back_inserter(r));

    vector<int> diff;

    pair<int,int> range(1,1e9);
    transform(l.begin(), l.end(), r.begin(), back_inserter(diff), [&range] (int left, int right) {
        if (right < range.first) {
            auto dif = range.first - right;
            range = {right, right};
            return dif;
        } else if (left > range.second) {
            auto dif = left - range.second;
            range = {left, left};
            return dif;
        } else {
            range.first = max(range.first, left);
            range.second = min(range.second, right);
            return 0;
        }
    });

    
    // calculate sum of differences
    cout << accumulate(diff.begin(), diff.end(), (uint64_t) 0) << "\n";
    
    return 0;
}
