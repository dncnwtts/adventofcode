#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

float dist(vector<long> v1, vector<long> v2);

int main() {
	ifstream inputStream;
	string strVar;

	vector<vector<long>> vec;

	vector<long> R = {0,0,0};

	vector<long> dists;
	vector<int> closest;
	vector<int> all_mindist_inds;

	vector<bool> connected;



	int num = 0;
	int last_ind=0;
	int min_ind;
	float min_dist, curr_dist;
	inputStream.open("08_input.txt");
	while (inputStream >> strVar)
	{
		R[0] = 0;
		R[1] = 0;
		R[2] = 0;
		for (int i = 0; i < strVar.length(); i++) {
		    if (strVar[i] == ',') {
			    num++;
		    }
		    else { 
			    R[num] = 10*R[num] + (strVar[i] - '0');
		    }
		}
		num = 0;
		vec.push_back(R);
	}
	inputStream.close();


	cout << "Another test!\n";

	for (auto v: vec) {
		for (int i = 0; i < 3; i++) {
			cout << v[i] << "\t";
		}
		cout<< endl;
	}


	cout << vec.size() << endl;

	vector<vector<float>> dist_matrix(vec.size(), vector<float>(vec.size()));

	cout << "Dist_matrix" << endl;
	cout << dist_matrix.size() << endl;
	cout << dist_matrix[0].size() << endl;
	cout << "Dist_matrix" << endl;



	for (int i = 0; i < vec.size(); i++) {
	    min_dist = numeric_limits<decltype(min_dist)>::max();
	    for (int j = 0; j < vec.size(); j++) {
		if (i >= j) {
		    curr_dist = numeric_limits<decltype(min_dist)>::max();
		}
		else
		{
	            curr_dist = dist(vec[i], vec[j]);
		}
		dist_matrix[i][j] = curr_dist;
		if (i >= j) {
			cout << "" << "\t";
		}
		else {
		    cout << curr_dist << "\t";
		}
	        if ((curr_dist != 0) & (curr_dist < min_dist)) {
	        	min_dist = curr_dist;
	        	min_ind = j;
	        }
	    }
	    cout << endl;
	    closest.push_back(min_ind);
	    dists.push_back(min_dist);
	}

	vector<int> i_mins;
	vector<int> j_mins;

	vector<vector<string>> loops;

	bool ok;
	for (int k = 0; k < 30; k++) {
	    // Find minimum values
	    min_dist = numeric_limits<decltype(min_dist)>::max();
	    int i_min, j_min;
	    i_mins.push_back(0);
	    j_mins.push_back(0);
	    for (int i = 0; i < vec.size(); i++) {
	    	for (int j = 0; j < vec.size(); j++) {
	                ok = true;
			if (k > 0) {
			    for (int l = 0; l < k; l++) {
			    	if ((i == i_mins[l]) & (j == j_mins[l])) ok = false;
			    }
			}
	    		if ((ok) & (dist_matrix[i][j] < min_dist)) {
	    			min_dist = dist_matrix[i][j];
	    			i_mins[k] = i;
	    			j_mins[k] = j;
	    		}
	    	}
	    }

	    cout << i_mins[k] << ", " << j_mins[k] << endl;


	    // for (int i = 0; i < 3; i++) {
	    // 	cout << vec[i_mins[k]][i] << "\t";
	    // }
	    // cout << endl;
	    // for (int i = 0; i < 3; i++) {
	    // 	cout << vec[j_mins[k]][i] << "\t";
	    // }
	    // cout << endl;
	    // cout << dist_matrix[i_mins[k]][j_mins[k]] << endl << endl;
	    if (loops.size() == 0) {
		    loops.push_back({to_string(j_mins[k]), to_string(i_mins[k])});
		    cout << "Initial push " << i_mins[k] << " " << j_mins[k] << endl;
	    }

	    else {
		    ok = true;
		    for (int i = 0; i < loops.size(); i++) {
		            bool i_in_loop = false;
		            bool j_in_loop = false;
			    for (int j = 0; j < loops[i].size(); j++) {
				    if (to_string(i_mins[k]) == loops[i][j]) {
					    i_in_loop = true;
				    }
				    if (to_string(j_mins[k]) == loops[i][j]) {
					    j_in_loop = true;
				    }
				  }
			            if (ok) {
			                if (i_in_loop & j_in_loop) {
			                        cout << " Do nothing " << i_mins[k] << " " << j_mins[k] << endl;
			                        ok = false;
			                }
			                else if (i_in_loop) {
			                        // Only add i
			                        cout << " only add j " << i_mins[k] << " " << j_mins[k] << " to " << i << endl;
			                        loops[i].push_back(to_string(j_mins[k]));
			                        ok = false;
			                }
			                else if (j_in_loop) {
			                        cout << " only add i " << i_mins[k] << " " << j_mins[k] << " to " << i << endl;
			                        loops[i].push_back(to_string(i_mins[k]));
			                        ok = false;
			                }
			                else {
			                        cout << " Nothing should be happening " << i_mins[k] << " " << j_mins[k] << endl;
			                        // OK continues to be true.
			                }
			    }
		    }
		    if (ok) {
		            cout << "Adding a new one " << i_mins[k] << " " << j_mins[k] << " to " << loops.size() << endl;
			    loops.push_back({to_string(i_mins[k]), to_string(j_mins[k])});
		    }
	    }

	}

	cout << loops.size() << endl;
	for (int i = 0; i < loops.size(); i++){
		cout << i << ":\t";
		for (int j =0; j < loops[i].size(); j++) {
			cout << loops[i][j] << "   ";
		}
		cout << endl;
	}

	return 0;

}

float dist(vector<long> v1, vector<long> v2) {
	long out = 0;
	long diff = 0;
	for (int i = 0; i < 3; i++) {
		diff = v1[i] - v2[i];
		out += diff*diff;
	}
	return sqrt(out);
}
