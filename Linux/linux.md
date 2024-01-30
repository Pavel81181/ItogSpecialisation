1. Использование команды cat в Linux

   - Создать два текстовых файла: "Pets"(Домашние животные) и "Pack animals"(вьючные животные), используя команду `cat` в терминале Linux. В первом файле перечислить собак, кошек и хомяков. Во втором — лошадей, верблюдов и ослов.

cat>pets.txt  
Charlie Dog  
Mars Cat  
Bonnie Hamster  
Lucie Dog  
Messi Cat  
Homa Hamster

cat>pack_animals.txt  
Wind Horse  
Alladin Camel  
Sancho Donkey  
Sivka Horse  
Vasia Camel  
Ia Donkey

   - Объединить содержимое этих двух файлов в один и просмотреть его содержимое.

   cat pets.txt pack_animals.txt > 'new.txt'   
   cat new.txt  
Charlie Dog  
Mars Cat  
Bonnie Hamster  
Lucie Dog  
Messi Cat  
Homa Hamster  
Wind Horse  
Alladin Camel  
Sancho Donkey  
Sivka Horse  
Vasia Camel  
Ia Donkey

   - Переименовать получившийся файл в "Human Friends".
   

   mv new.txt Human_friends.txt

 - Пример конечного вывода после команды “ls” :  

pavel@pavel-VirtualBox:~/Kontrol$ ls  

Human_friends.txt  pack_animals.txt  pets.txt

2. Работа с директориями в Linux
   - Создать новую директорию и переместить туда файл "Human Friends".

   mkdir New  
    sudo mv Human_friends.txt New/


3. Работа с MySQL в Linux. “Установить MySQL на вашу вычислительную машину ”
   - Подключить дополнительный репозиторий MySQL и установить один из пакетов из этого репозитория.

wget https://dev.mysql.com/get/mysql-apt-config_0.8.23-1_all.deb  
sudo dpkg -i mysql-apt-config_0.8.23-1_all.deb  
sudo apt-get update  
sudo apt-get install mysql-server

4. Управление deb-пакетами
   - Установить и затем удалить deb-пакет, используя команду `dpkg`.

wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-ce-cli_20.10.13~3-0~ubuntu-jammy_amd64.deb  
sudo dpkg -i docker-ce-cli_20.10.13~3-0~ubuntu-jammy_amd64.deb  
sudo dpkg -r docker-ce-cli

5. История команд в терминале Ubuntu
   - Сохранить и выложить историю ваших терминальных команд в Ubuntu.
В формате: Файла с ФИО, датой сдачи, номером группы(или потока)

history >> BazhinPA_300124_4719.txt



