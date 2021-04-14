INDEX=$1

if [[ "$INDEX" == "normal" ]];
then
	echo ""
	echo "Normal Mode!"
	echo ""
	echo "Step 1: Making sure you didn't leave a mess... I told you to clean."
	rm -f -r tester_linux
	rm -f -r tester_mac
	cd srcs_linux
	make fclean
	cd ../srcs_mac
	make fclean
	cd ..
	echo "Step 2: 'make' on ./srcs_linux/Makefile"
	cd srcs_linux
	make re
	echo "Step 3: Make a new directory ./tester_linux/ to put the tester files for easy accessibility."
	cd ..
	mkdir tester_linux
	cd tester_linux
	echo "Step 4: Copy libasm.a, main.c and libasm.h from ./srcs_linux/ and ./main/ to ./tester_linux/"
	cp ../srcs_linux/libasm.a .
	cp ../main/main.c .
	cp ../main/libasm.h .
	echo "Step 5: Compiling main.c with libasm.a to form an executable file."
	gcc -Wall -Wextra -Werror main.c libasm.a -o linux_normal
	echo "Step 6: Running the executable file called linux_normal."
	./linux_normal
elif [[ "$INDEX" == "debugger" ]];
then
	echo ""
	echo "Debugger Mode!"
	echo ""
	echo "Step 1: Making sure you didn't leave a mess... I told you to clean."
	rm -f -r tester_linux
	rm -f -r tester_mac
	cd srcs_linux
	make fclean
	cd ../srcs_mac
	make fclean
	cd ..
	echo "Step 2: 'make' on ./srcs_linux/Makefile"
	cd srcs_linux
	make re
	echo "Step 3: Make a new directory ./tester_linux/ to put the tester files for easy accessibility."
	cd ..
	mkdir tester_linux
	cd tester_linux
	echo "Step 4: Copy libasm.a, main.c, libasm.h and .s files from ./srcs_linux/ and ./main/ to ./tester_linux/"
	cp ../srcs_linux/libasm.a .
	cp ../main/main.c .
	cp ../main/libasm.h .
	cp ../srcs_linux/ft_strlen.s .
	echo "Step 5: Compiling main.c with libasm.a to form an executable file."
	gcc -Wall -Wextra -Werror main.c libasm.a -o linux_debugger
	echo "Step 6: Running the executable file called linux_debugger."
	ddd ./linux_debugger
else
	echo ""
	echo "Please type:"
	echo ""
	echo "bash linux.sh normal   - for normal compile."
	echo "bash linux.sh debugger - for debugger mode with ddd."
	echo ""
fi
