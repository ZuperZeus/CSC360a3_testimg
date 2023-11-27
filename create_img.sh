#!/bin/bash
gcc make_image_file.c -o make_image_file
./make_image_file
rm make_image_file
make>/dev/null
./diskput image.img root/file1.txt file1.txt
./diskput image.img root/file2.TXT file2.TXT
./diskput image.img root/FILE3.txt FILE3.txt
./diskput image.img root/FILE4.TXT FILE4.TXT
./diskput image.img root/foo.txt foo.txt
./diskput image.img root/hello_world.txt hello_world.txt
./diskput image.img root/readme.txt/readme.txt /readme.txt/readme.txt
./diskput image.img root/s_d-a/s_d-b/s_d-c/s_d-d/s_d-e/s_d-f/s_d-g/s_d-h/lorem_ipsum /s_d-a/s_d-b/s_d-c/s_d-d/s_d-e/s_d-f/s_d-g/s_d-h/lorem_ipsum
./diskput image.img root/subdir.1/subdir.2/subdir.3/2000_zeroes.txt /subdir.1/subdir.2/subdir.3/2000_zeroes.txt
./diskput image.img root/subdirA/subdirAA/subdirAAA/count_to_2048.txt /subdirA/subdirAA/subdirAAA/count_to_2048.txt
./diskput image.img root/subdirA/subdirAB/hello_world.py /subdirA/subdirAB/hello_world.py
