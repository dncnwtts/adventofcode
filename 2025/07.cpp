#include <iostream>
#include <vector>
#include <string> 
#include <fstream>
#include <unistd.h>

using namespace std;

// const int height = 16;
// const int width = 15;
const int height = 142;
const int width = 141;
//
//
long n_paths = 0;

int main() {


	ifstream inputStream;
	string strVar;

	char grid[height][width];
	char grid_orig[height][width];


	long grid_result[height][width];

	int i = 0;

	inputStream.open("07_input.txt");
	while (inputStream >> strVar)
	{
		for (int j = 0; j < width; j++) {
			grid[i][j] = strVar[j];
			grid_orig[i][j] = strVar[j];
			grid_result[i][j] = 0;
		}
		i++;
	}
	inputStream.close();

	int num_splits = 0;
	for (int i = 0; i < height - 1; i++) {
		for (int j = 0; j < width; j++) {
			if (grid[i][j] == 'S') {
				if (grid[i+1][j] == '.') {
					grid[i][j] = '|';
					grid[i+1][j] = 'S';
				}
				else if (grid[i+1][j] == '^') {
					grid[i+1][j-1] = 'S';
					grid[i+1][j+1] = 'S';
					grid[i][j] = '|';
					num_splits++;
				}
				else {
					grid[i][j] = '|';
				}
			}
		}
	}

	for (int j = 0; j < width; j++) {
	    if (grid[height-1][j] == 'S') grid[height-1][j] = '|';
	}

	cout << num_splits << endl;



	for (int k = 0; k < height; k++) {
		for (int l = 0; l < width; l++) {
			grid[k][l] = grid_orig[k][l];
		}
	}


	for (int l = 0; l < width; l++) {
		if (grid[0][l] == 'S') {
			grid_result[0][l] = 1;
		}
	}

	for (int k = 1; k < height; k++) {
		for (int l = 0; l < width; l++) {
			if (grid[k][l] == '.') grid_result[k][l] += grid_result[k-1][l];
			if (grid[k][l] == '^') {
				grid_result[k+1][l+1] += grid_result[k-1][l];
				grid_result[k+1][l-1] += grid_result[k-1][l];
			}
		}
	}

	n_paths = 0;
	for (int l = 0; l < width; l++) {
		n_paths += grid_result[height-1][l];
	}
	cout << n_paths << endl;

	return 0;
}
