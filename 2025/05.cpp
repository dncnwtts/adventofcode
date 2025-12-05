#include <iostream>
#include <iomanip>
#include <vector>
#include <string>
#include <fstream>
#include <algorithm>

using namespace std;

int main() {

	ifstream inputStream;
	string strVar;

	int range_ind = 0;
	int ingr_ind = 0;

	const int N = 2000;

	vector<long> lower_lims (N);
	vector<long> upper_lims (N);
	vector<vector<long>> lims (2, vector<long>(N));
	vector<vector<long>> new_lims (2, vector<long>(N));
	vector<long> ingredients(N);

	inputStream.open("05_input.txt");
	while (inputStream >> strVar)
	{
		auto n = strVar.find('-');
		if ( n !=  std::string::npos) {
			lims[0][range_ind] = stol(strVar.substr(0,n));
			lims[1][range_ind] = stol(strVar.substr(n+1, std::string::npos));
			range_ind++;
		}
		else {
			ingredients[ingr_ind] = stol(strVar);
			ingr_ind++;
		}
	}
	inputStream.close();

	long num_fresh = 0;
	for (int i = 0; i < ingr_ind; i++) {
		// Find lowest index that ingredient[i] is above.
		for (int j = 0; j < range_ind; j++) {
		    if ((ingredients[i] >= lims[0][j]) & (ingredients[i] <= lims[1][j])) {
		           num_fresh++;
		           break;
		    }
		}
	}

	cout << num_fresh << endl;
        for (auto &i : lims)
            sort(i.begin(), i.end());
  


	for (int i = N - range_ind; i < N; i++) {
		new_lims[0][i] =  lims[0][i];
		new_lims[1][i] =  lims[1][i];
	}

	num_fresh = 0;

	for (int j = 0; j < 10; j++) {
	    for (int i = N-2; i >= N - range_ind; i--) {
	    	if (new_lims[1][i] >= new_lims[0][i+1]) {
	    		new_lims[1][i]   = new_lims[1][i+1];
	    		new_lims[0][i+1] = new_lims[0][i];
	    	}
	    }
	}

	for (int i = N - range_ind; i<N-1; i++) {
	    for (int j = i+1; j<N; j++) {
		if (new_lims[0][i] == new_lims[0][j]) {
			// When we do the calculation, range will be calculated as
			// lims[1][j] - lims[0][j] + 1
			new_lims[0][j] = new_lims[1][j] + 1;
		}
	    }
	}

	for (int i = N - range_ind; i < N; i++) {
		num_fresh += new_lims[1][i] - new_lims[0][i] + 1;
	}

	cout << num_fresh << endl;


	return 0;
}
