#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;


int main() {
	ifstream inputStream;
	string strVar;

	vector<long> x;
	vector<long> y;

	inputStream.open("09_input.txt");
	while (inputStream >> strVar)
	{
		int comma_ind;
		for (int i = 0; i < strVar.length(); i++) {
		    if (strVar[i] == ',') {
			    x.push_back(stol(strVar.substr(0,i)));
			    comma_ind = i;
		    }
		}
	        y.push_back(stol(strVar.substr(comma_ind+1, strVar.length())));
	}
	inputStream.close();


	long height, width;
	long max_area = 0;
	for (int i = 0; i < x.size(); i ++ ) {
		for (int j = i; j < x.size(); j++) {
			width = x[i] - x[j] + 1;
			height = y[i] - y[j] + 1;
			if (max_area < width*height) {
				max_area = width*height;
			}
		}
	}

	cout << max_area << endl;
	max_area = 0;
	bool inside, green, left, right, above, below, write_condition;
	int k;
	long top_edge, bottom_edge, left_edge, right_edge;

	// When I look at the points, it's basically a circle, except you can't cross the center.
	// With this structure, the problem becomes a bit simpler, namely, you can't have one y
	// above 50_000 and another below it.
	for (int i = 0; i < x.size(); i ++ ) {
		for (int j = i; j < x.size(); j++) {
			inside = true;
			green = false;
			k = 0;
			if (i == j) inside = false;
			left = x[i] > x[j];
			above = y[j] > y[i];
			if (left) {
			        width = x[i] - x[j] + 1;
				left_edge = x[j];
				right_edge = x[i];
			}
			else {
			        width = x[j] - x[i] + 1;
				left_edge = x[i];
				right_edge = x[j];
			}

			if (above) {
			        height = y[j] - y[i] + 1;
				top_edge = y[j];
				bottom_edge = y[i];
				if ((y[j] > 50000) & (y[i] < 50000)) inside = false;
			}
			else {
			        height = y[i] - y[j] + 1;
				top_edge = y[i];
				bottom_edge = y[j];
				if ((y[i] > 50000) & (y[j] < 50000)) inside = false;
			}
			if (inside) {
				if ((max_area < width*height)) {
					max_area = width*height;
				        cout << x[i] << " , " << y[i] << endl;
				        cout << x[j] << " , " << y[j] << endl;
				        cout << width*height << endl;
				}
			}
	    }
    }

	cout << max_area << endl;

	return 0;
}
