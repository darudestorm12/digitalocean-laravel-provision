# Readme

I found myself making digital ocean clean install Laravel droplets again and again for quick testing purposes and I needed a way to do this faster. While Laravel Forge is a great service I do not need 90% of its features at this moment. If you want to deploy a production server I do recommend this.

# Useage

Create a new Droplet and select "LEMP on 14.04" under applications. Check "User data" and enter the contents of provision.sh. In a few minutes you should be good to go. (wait for a little bit after your droplet is created, this script will run for a while after)

# What it does

Pretty straight forward it downloads and sets the most basic dependencies. Modifies nginx default server block. Installs composer, installs laravel and creates a new project using the default server block

# Notice

This is NOT meant for production useage. This is not even meant for prolonged development useage. Permissions are set at 777 and no aditional user is created, root owns everything. Also this is as basic as it gets. There's no caching, etc and MySQL is not setup NOR secured. Improvements are welcomed. Just do a pull request
