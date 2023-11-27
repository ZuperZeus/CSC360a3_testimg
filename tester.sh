#!/bin/bash
if [[ -f temp_file ]] 
then
	echo "This script will overwrite the file named temp_file. Please rename it to avoid data loss"
	exit
fi
if [[ -f test_file ]]
then
	echo "This script will overwrite the file named test_file. Please rename it to avoid data loss"
	exit
fi
if [[ -f temp.img ]]
then
	echo "This script will overwrite the file named temp.img. Please rename it to avoid data loss"
	exit
fi
echo "Running make..."
make>/dev/null
if ! [[ $? -eq 0 ]]
then 
	echo "make failed, exiting..."
	exit
fi
echo "Testing diskinfo..."
./diskinfo image.img > temp_file
diff -s temp_file output/diskinfo
echo "Testing disklist..."
./disklist image.img /readme.txt > temp_file
diff -s temp_file output/diskinfo#readme.txt
# directory s_d-a
./disklist image.img /s_d-a > temp_file
diff -s temp_file output/diskinfo#s_d-a
./disklist image.img /s_d-a/s_d-b > temp_file
diff -s temp_file output/diskinfo#s_d-a#s_d-b
./disklist image.img /s_d-a/s_d-b/s_d-c > temp_file
diff -s temp_file output/diskinfo#s_d-a#s_d-b#s_d-c
./disklist image.img /s_d-a/s_d-b/s_d-c/s_d-d > temp_file
diff -s temp_file output/diskinfo#s_d-a#s_d-b#s_d-c#s_d-d
./disklist image.img /s_d-a/s_d-b/s_d-c/s_d-d/s_d-e > temp_file
diff -s temp_file output/diskinfo#s_d-a#s_d-b#s_d-c#s_d-d#s_d-e
./disklist image.img /s_d-a/s_d-b/s_d-c/s_d-d/s_d-e/s_d-f > temp_file
diff -s temp_file output/diskinfo#s_d-a#s_d-b#s_d-c#s_d-d#s_d-e#s_d-f
./disklist image.img /s_d-a/s_d-b/s_d-c/s_d-d/s_d-e/s_d-f/s_d-g > temp_file
diff -s temp_file output/diskinfo#s_d-a#s_d-b#s_d-c#s_d-d#s_d-e#s_d-f#s_d-g
# directory subdir.1
./disklist image.img /subdir.1 > temp_file
diff -s temp_file output/subdir.1
./disklist image.img /subdir.1/subdir.2 > temp_file
diff -s temp_file output/subdir.1#subdir.2
./disklist image.img /subdir.1/subdir.2/subdir.3 > temp_file
diff -s temp_file output/subdir.1#subdir.2#subdir.3
# directory subdirA
./disklist image.img /subdirA > temp_file
diff -s temp_file output/subdirA
./disklist image.img /subdirA/subdirAA > temp_file
diff -s temp_file output/subdirA#subdirAA
./disklist image.img /subdirA/subdirAA/subdirAAA > temp_file
diff -s temp_file output/subdirA#subdirAA#subdirAAA
./disklist image.img /subdirA/subdirAB > temp_file
diff -s temp_file output/subdirA#subdirAB
echo "Testing diskget..."
./diskget image.img file1.txt temp_file
diff -s temp_file root/file1.txt
./diskget image.img file2.TXT temp_file
diff -s temp_file root/file2.TXT
./diskget image.img FILE3.txt temp_file
diff -s temp_file root/FILE3.txt
./diskget image.img FILE4.TXT temp_file
diff -s temp_file root/FILE4.TXT
./diskget image.img foo.txt temp_file
diff -s temp_file root/foo.txt
./diskget image.img hello_world.txt temp_file
diff -s temp_file root/hello_world.txt
./diskget image.img /readme.txt/readme.txt temp_file
diff -s temp_file root/readme.txt/readme.txt
./diskget image.img /s_d-a/s_d-b/s_d-c/s_d-d/s_d-e/s_d-f/s_d-g/s_d-h/lorem_ipsum temp_file
diff -s temp_file root/s_d-a/s_d-b/s_d-c/s_d-d/s_d-e/s_d-f/s_d-g/s_d-h/lorem_ipsum
./diskget image.img /subdir.1/subdir.2/subdir.3/2000_zeroes.txt temp_file
diff -s temp_file root/subdir.1/subdir.2/subdir.3/2000_zeroes.txt
./diskget image.img /subdirA/subdirAA/subdirAAA/count_to_2048.txt temp_file
diff -s temp_file root/subdirA/subdirAA/subdirAAA/count_to_2048.txt
./diskget image.img /subdirA/subdirAB/hello_world.py temp_file
diff -s temp_file root/subdirA/subdirAB/hello_world.py
echo "Testing diskput/diskget..."
echo "This is some test text that will be in the file sent to the image.img file. This file will be named 'test_file' and will be copied using diskput.
These
are
some
newlines." > test_file
cp image.img temp.img
cat test_file > temp_file
./diskput temp.img test_file /test1.txt
./diskget temp.img test1.txt temp_file
diff -s test_file temp_file 
./diskput temp.img test_file /s_d-a/s_d-b/s_d-c/s_d-d/s_d-e/s_d-f/s_d-g/s_d-h/test2.txt
./diskget temp.img /s_d-a/s_d-b/s_d-c/s_d-d/s_d-e/s_d-f/s_d-g/s_d-h/test2.txt temp_file
diff -s test_file temp_file 
./diskput temp.img test_file /subdirA/subdirAA/test3.txt
./diskget temp.img /subdirA/subdirAA/test3.txt temp_file
diff -s test_file temp_file 
echo "Cleaning files..."
rm temp_file
rm test_file
rm temp.img
make clean
