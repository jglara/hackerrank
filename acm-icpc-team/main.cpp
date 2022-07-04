#include <iostream>
#include <algorithm>
#include <iterator>
#include <vector>
#include <bitset>
#include <numeric>

const size_t MAX = 500;

using atendee_t = std::bitset<MAX>;

int main()
{
  int n(0);
  int m(0);

  std::cin >> n >> m;

  std::vector< atendee_t > atendees(n);
  std::transform(std::istream_iterator<std::string>(std::cin),
                 std::istream_iterator<std::string>(),
                 atendees.begin(),
                 [](auto line) {return atendee_t(line); });


  std::pair<int, int> result = std::make_pair(0,0);
  for(auto ptr=atendees.cbegin(); ptr != atendees.cend(); ++ptr) {

    std::pair<int,int> partial = std::accumulate(std::next(ptr), atendees.cend(), std::make_pair(0,0), 
                                     [ptr] (auto acum, const auto &atendee2) {
                                       int common_count = (*ptr | atendee2).count();

                                       if (acum.first < common_count) {
                                         return std::make_pair(common_count, 1);
                                       } else if (acum.first == common_count) {
                                         return std::make_pair(acum.first, acum.second+1);
                                       } else {
                                         return acum;
                                       }
                                     });
    

    if (result.first < partial.first) {
      result = partial;
    } else if (result.first == partial.first) {
      result.second+= partial.second;
    } 
  }

  std::cout << result.first << "\n" << result.second << "\n";


//  std::cout << "N= " << n << " M= " << m << "\n"
//            << "size= " << atendees.size() << " " << atendees[0].to_string() << "\n";
  
  
}
