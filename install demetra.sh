#Установка nginx
sudo apt install -y nginx

#Запуск nginx
sudo systemctl start nginx

#Установка пакета Python
sudo apt install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools

#Установка виртуальной среды
sudo apt install -y virtualenv

#Создание директории для виртуальной среды
mkdir ~/demetra

#Создание виртуальной среды
cd ~/demetra
python3 -m virtualenv demetra

#Активация вирутальной среды
source demetraenv/bin/activate

#Установка модуля uwsgi flask
pip install -y wheel
pip install -y uwsgi flask

#Создание исполняемого приложения
nano ~/demetra/demetra.py 

#Открытие порта 5000 и проверка работоспособности приложения
#sudo ufw allow 5000
#python demetra.py

#Создание точки входа WSGI
nano ~/demetra/wsgi.py

#Деактивация виртуальной среды
deactivate

#Создание конфигурационного файла uWSGI
nano ~/demetra/demetra.ini

#Создание файла в SystemD для инициализации службы 
sudo nano /etc/systemd/system/demetra.service

#Запуск службы demetra

sudo systemctl start demetra
sudo systemctl enable demetra

#Конфигурация Nginx для запросов
sudo nano /etc/nginx/sites-available/demetra

#Создание ссылки для включения серверного блока
sudo ln -s /etc/nginx/sites-available/demetra /etc/nginx/sites-enabled

#Проверка работоспособности Nginx
sudo nginx -t

#Перезапуск Nginx
sudo systemctl restart nginx

#Если ранее проводился тест с открытием порта 5000, в целях безопасности его следует закрыть.
#sudo ufw delete allow 5000
#Выдача разрешений Nginx
sudo ufw allow 'Nginx Full'
