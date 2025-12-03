#include <iostream>
#include <vector>
#include <string>
#include <fstream>

using namespace std;

int main() {

	ifstream inputStream;
	string strVar;
	int ind1, ind2;
	int val1, val2;

	int ans1 = 0;



	val1 = -1;
	val2 = -1;
	inputStream.open("03_input.txt");
	while (inputStream >> strVar)
	{
	    for (int k = 0; k < strVar.length() - 1; k++) {
		    if (strVar[k] - '0' > val1) {
			    ind1 = k;
			    val1 = strVar[k] - '0';
		    }
	    }
	    for (int k = ind1 + 1; k < strVar.length(); k++) {
		    if (strVar[k] - '0' > val2) {
			    val2 = strVar[k] - '0';
		    }
	    }
	    ans1 += 10*val1 + val2;
	    val1 = -1;
	    val2 = -1;
	}
	inputStream.close();

	cout << ans1 << endl;


	val1 = -1;
	ind1 = -1;

	const int num_digits = 12;
	long ans_temp = 0;
	long ans2 = 0;

	inputStream.open("03_input.txt");
	while (inputStream >> strVar)
	{
	    for (int nl = num_digits; nl > 0; nl--) {
	        for (int k = ind1 + 1; k < strVar.length() - nl + 1; k++) {
	                if (strVar[k] - '0' > val1) {
	            	    ind1 = k;
	            	    val1 = strVar[k] - '0';
	                }
	        }
	    ans_temp = 10*ans_temp + val1;
	    val1 = -1;
	    }
	    ans2 += ans_temp;
	    ans_temp = 0;
	    ind1 = -1;
	}
	inputStream.close();

	cout << ans2 << endl;


	return 0;
}
