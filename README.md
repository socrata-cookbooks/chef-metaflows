# chef-metaflows
Note: This cookbook is an imperfect example of open source as 
there are still several elements internal to Socrata in the 
sensor recipe. These will be removed in a future release. 

The cookbook as is has a few things that are useful to someone 
looking to automate the Metaflows sensor/agents setup. The agents
recipe uses runit to distribute the agents with Chef. The sensor
recipe has an expect script in the files folder (register_sensor )
that can interact with the command line on boot and register
the sensor with the saas. Again we used runit to restart the 
service so the collector will run. 

The sensor recipe runs on the Metaflows Silver Hourly AMI, 
available for any region in the AWS Marketplace. It runs on 
CentOS 6.7 and no other platform is supported, although the 
agents work on any Linux. 

Documentation on Metaflows and AWS (without automation) can be 
found at the [Metaflows Wiki](https://www.metaflows.com/wiki/AWS_Set_Up) 
