#include <iostream>
#include <vector>
#include <string>
#include <fstream>

using namespace std;

int main() {


	int n_numbers = 0;
	int n_ops = 0;
	int n_rows;
        vector<long> numbers;
	vector<string> ops;


	ifstream inputStream;
	string strVar;


	inputStream.open("06_input.txt");
	while (inputStream >> strVar)
	{
		if ((strVar == "*") | (strVar == "+")) {
		    n_ops++;
		    ops.push_back(strVar);
		}
		else {
		    numbers.push_back(stol(strVar));
		    n_numbers++;
		}
	}
	inputStream.close();

	n_rows = n_numbers / n_ops;

	// Initialization finished; time to do the operations

	long ans_col;
	long solution = 0; for (int i = 0; i < n_ops; i++) {
		if (ops[i] == "*") {
			ans_col = 1;
			for (int j = 0; j < n_rows; j++) {
				ans_col *= numbers[n_ops*j + i];
			}
		}
		if (ops[i] == "+") {
			ans_col = 0;
			for (int j = 0; j < n_rows; j++) {
				ans_col += numbers[n_ops*j + i];
			}
		}
		solution += ans_col;
	}
	cout << solution << endl;


	// In the new version, whitespace matters...

	numbers.clear();

	int line_length;

	string line;
	ifstream file("06_input.txt");
	while (getline(file, line))
	{
		line_length = line.length();
	}


	file.clear();
	file.seekg(0);

	string char_arr[n_rows+1][line_length];
	int ones_place[n_ops];

	int row = 0;
	int op = 0;

	while (getline(file, line))
	{
		if (row < n_rows) {
		    for (int i = 0; i < line_length; i++)
		    {
		    	char_arr[row][i] = line[i];
		    }
		    row++;
		}
		else {
		    for (int i = 0; i < line_length; i++)
		    {
			    if ((line[i] == '*') | (line[i] == '+')) {
				    ones_place[op] = i;
				    char_arr[n_rows][i] = line[i];
				    op++;
			    }
		    }
		}

	}



	long current_number, current_sum, ans2;
	int current_op = 0;

	ans2 = 0;
	current_sum = 0;
	current_number = 0;

	string oper;

	for (int i = 0; i < line_length; i++) {
	    current_number = 0;
	    if ((i == 0) & (current_sum == 0)) {
	       oper = char_arr[n_rows][ones_place[current_op]];
	       if (oper == "+") {
	               current_sum = 0;
	       }
	       else {
	               current_sum = 1;
	       }
	    }
	    for (row = 0; row < n_rows; row++) {
		    if (char_arr[row][i] != " ") {
			    current_number = 10*current_number + stol(char_arr[row][i]);
		    }
	    }
	    if (current_number == 0) {
	        current_op++;
		ans2 += current_sum;
		current_sum = 0;
	        oper = char_arr[n_rows][ones_place[current_op]];
	        if (oper == "+") {
	                current_sum = 0;
	        }
	        else {
	                current_sum = 1;
	        }
	    }
	    else {
		if (oper == "+") current_sum += current_number;
		if (oper == "*") current_sum *= current_number;
	    }
	    current_number = 0;
	}
	oper = char_arr[n_rows][ones_place[current_op]];
	ans2 += current_sum;

	cout << ans2 << endl;
}
