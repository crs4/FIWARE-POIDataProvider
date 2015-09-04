$ docker build -t crs4_csdk/poidp .
$ docker run -d -p 3000:22 -p 5000:80 crs4_csdk/poidp:latest
## the image passwd is 'root'
$ bash -x install.sh
$ ssh -p 3000 root@localhost
root@localhost's password: 
Welcome to Ubuntu 14.04.3 LTS (GNU/Linux 4.0.5-gentoo-zag03 x86_64)

 * Documentation:  https://help.ubuntu.com/

root@11e698a93ee3:~# bash -x fix.sh
root@11e698a93ee3:~# exit

$ curl "http://localhost:5000/poi_dp/radial_search.php?lat=1&lon=1&category=test_poi"
{"pois":{"ae01d34a-d0c1-4134-9107-71814b4805af":{"fw_core":{"location":{"wgs84":{"latitude":1,"longitude":1}},"categories":["test_poi"],"name":{"":"Test POI 1"}}}}}

$ 


