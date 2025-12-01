#include <iostream>
#include <vector>
#include <string>
#include <fstream>

int main() {
	std::vector<std::string> v0 = 
	{"L68",
        "L30",
        "R48",
        "L5",
        "R60",
        "L55",
        "L1",
        "L99",
        "R14",
        "L100"};



	int filelen = 0;
	std::string s;

	std::vector<std::string> v;

	std::ifstream file("01_input.txt");
        while(std::getline(file, s)){
        	v.push_back(s);
        }

	int dial = 50;
	int password = 0;


	for(auto i : v){
	    if (i[0] == 'L') {
	        dial -= stoi(i.substr(1));
	    }
	    else {
	        dial += stoi(i.substr(1));
	    }
	    if (dial < 0) {
		    dial += 100;
	    }
	    dial = dial % 100;
	    if (dial == 0) {
		    password++;
	    }
	}


	std::cout << password << std::endl;

	password = 0;
	dial = 50;
	int n_passes;
	int dist;

	for(auto i : v){
	    dist = stoi(i.substr(1));
	    n_passes = dist / 100;
	    password = password + n_passes;
	    dist = dist % 100;
	    if (i[0] == 'L') {
	        if (dial == 0) {
	                dial = 100;
	        }
		if (dist > dial) {
			password++;
		}
	        dial -=  dist;
	    }
	    else {
		if (dist + dial > 100) {
			password++;
		}
	        dial +=  dist;
	    }
	    dial = dial % 100;
	    if (dial == 0) {
		    password++;
	    }
	    if (dial < 0) {
		    dial += 100;
	    }

	}


	std::cout << password << std::endl;

	return 0;
}
