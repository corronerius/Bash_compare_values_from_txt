#!/bin/bash

email=user@domain.com       #Куда отправляем

tmp_file=/tmp/t.txt         #Исходный файл

threshold=2000000

echo "From: <info@domein.com>" > $tmp_file
echo "To: <$email>" >> $tmp_file
echo "Subject: Too long transaction" >> $tmp_file
echo "" >> $tmp_file

arr=($(awk '{print $3}' /$tmp_file))           #Получаем массив

min=${arr[2]}

for n in "${arr[@]:0:2}" ; do              #находим наименьшее значение из елементов 0-2 массива
    ((n < min)) && min=$n                  
done

var=$(echo "${arr[3]}-$min" |bc)           #находим разницу между мах и последним элементом

if  (($var > 0 && $var > $threshold));                                                                     # если больше 2М отправляем
        then sendmail -f "info@domain.com" $email < $tmp_file;
fi

