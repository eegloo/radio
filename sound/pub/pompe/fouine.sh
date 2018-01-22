#!bin/bash/
i=1
while ((i!=169))
do
    echo $i
    url=$(sed -n "$i p" oo)
    wget $url
    echo $i
    ((i+=1))
done
echo 'ok'
