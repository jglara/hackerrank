#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>
#include <unordered_map>
#include <unordered_set>
#include <set>

using namespace std;

// Complete the fewestTowers function below.
long fewestTowers(vector<int> x, vector<int> y) {
    // Return the minimum number of towers that need to be constructed so that the condition is satisfied.
    int N(x.size());
    unordered_map<int, set<int>> by_x; by_x.reserve(N);
    unordered_map<int, set<int>> by_y; by_y.reserve(N);

    for (int i=0; i < N; ++i) {
        by_x[ x[i] ].insert(y[i]);
        by_y[ y[i] ].insert(x[i]);
    }

    set< pair<int,int> >missing;

    for_each(by_x.begin(), by_x.end(), [&missing] (const pair<int , set<int>> &p) {
        if (not p.second.empty()) {
            int last(* p.second.begin() + 1) ;
            for (auto y: p.second) {
                for (int m=last; m < y; ++m) {
                    missing.insert( make_pair(p.first, m));
                }
                last = y + 1;
            }
        }
    });

    for_each(by_y.begin(), by_y.end(), [&missing] (const pair<int , set<int>> &p) {
        if (not p.second.empty()) {
            int last(* p.second.begin() + 1);
            for (auto x: p.second) {
                for (int m=last; m < x; ++m) {
                    missing.insert( make_pair(m, p.first));
                }
                last = x + 1;
            }
            
        }
    });

    
    return missing.size();

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