#Script By Teguh Sulistian
#PPKLP - BIG
#INTERPOLATION_METHOD

echo -n '1. Input Data : '
read input1
echo ' Please Select Your Interpolation Method'
echo ' Nearneighbor (1)'
echo ' Spline (2)'
echo ' TIN (3)'
echo -n ' Interpolation Method: '
read test

if [[ $test == 1 ]]; then
	#Nearneighbor
	echo -n '2. Output File (.tiff): '
	read input2
	echo -n '3. Output Resolution x,y: '
	read input3
	echo -n '4. Search Radius: '
	read input4

	lon0=`awk 'NR == 1 { min=$1 } { if ($1<min) min=$1;} END {print min}' ${input1}`
	lat0=`awk 'NR == 1 { min=$2 } { if ($2<min) min=$2;} END {print min}' ${input1}`
	lonf=`awk 'NR == 1 { max=$1 } { if ($1>max) max=$1;} END {print max}' ${input1}`
	latf=`awk 'NR == 1 { max=$2 } { if ($2>max) max=$2;} END {print max}' ${input1}`
	echo "bounding box $lon0 to $lonf and $lat0 to $latf"

	gmt nearneighbor ${input1} -R$lon0/$lonf/$lat0/$latf -I${input3}/${input3} -V -Gdem.grd -S${input4}
	gdal_translate -of "GTiff" dem.grd ${input2}
	rm dem.grd

	echo "PROCESS DONE"

elif [[ $test == 2 ]]; then
	#Spline
	echo -n '2. Output File (.tiff): '
	read input2
	echo -n '3. Output Resolution x,y: '
	read input3
	echo -n '4. Tension: '
	read input4

	lon0=`awk 'NR == 1 { min=$1 } { if ($1<min) min=$1;} END {print min}' ${input1}`
	lat0=`awk 'NR == 1 { min=$2 } { if ($2<min) min=$2;} END {print min}' ${input1}`
	lonf=`awk 'NR == 1 { max=$1 } { if ($1>max) max=$1;} END {print max}' ${input1}`
	latf=`awk 'NR == 1 { max=$2 } { if ($2>max) max=$2;} END {print max}' ${input1}`
	echo "bounding box $lon0 to $lonf and $lat0 to $latf"

	gmt surface ${input1} -R$lon0/$lonf/$lat0/$latf -I${input3}/${input3} -T${input4} -V -Gdem.grd
	gdal_translate -of "GTiff" dem.grd ${input2}
	rm dem.grd

	echo "PROCESS DONE"

elif [[ $test == 3 ]]; then
	#TIN
	echo -n '2. Output File (.tiff): '
	read input2
	echo -n '3. Output Resolution x,y: '
	read input3

	lon0=`awk 'NR == 1 { min=$1 } { if ($1<min) min=$1;} END {print min}' ${input1}`
	lat0=`awk 'NR == 1 { min=$2 } { if ($2<min) min=$2;} END {print min}' ${input1}`
	lonf=`awk 'NR == 1 { max=$1 } { if ($1>max) max=$1;} END {print max}' ${input1}`
	latf=`awk 'NR == 1 { max=$2 } { if ($2>max) max=$2;} END {print max}' ${input1}`
	echo "bounding box $lon0 to $lonf and $lat0 to $latf"

	gmt triangulate ${input1} -Gdem.grd -R$lon0/$lonf/$lat0/$latf -I${input3}/${input3} -V
	gdal_translate -of "GTiff" dem.grd ${input2}
	rm dem.grd

	echo "PROCESS DONE"

else 
	echo 'PLEASE REBOOT PROGRAM'
fi
