#!/bin/bash


echo | awk '{

 i=0
 while (( getline < "ref.pdb" ) > 0 ) {

	 if ( $1 == "ATOM" ) {
		 ref[++i,1] = $6
		 ref[i,2] = $7
		 ref[i,3] = $8
	}
}

confID = 0
while (( getline < "imorph_movie.pdb" ) > 0 ) {

	if ( $1 ~ /MODEL/ ) {
		confID ++
		atomID = 0
	}
	if ( $1 == "ATOM" ) {
		coord[confID,++atomID,1] = $6
		coord[confID,atomID,2] = $7
		coord[confID,atomID,3] = $8
	}

}

N=atomID

for(i=1;i<=confID;i++){
	sum = 0
	for(j=1;j<=atomID;j++){
		sum += (coord[i,j,1] - ref[j,1])^2 + (coord[i,j,2] - ref[j,2])^2  + (coord[i,j,3] - ref[j,3])^2
	}
	print i, sqrt(sum/N)
}
}'

