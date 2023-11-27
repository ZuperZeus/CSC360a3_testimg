#!/bin/bash
make>/dev/null
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
rm temp_file
