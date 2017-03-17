# Network Registry

### Info:

This template creates a MariaDB master/slave cluster on top of Rancher.
When deployed from the catalog, a two node cluster is created with a database, root password, database user and password.
 
The cluster is set up for replication from the master node to multiple slave nodes. 
The cluster sits behind a light weight proxy layer that forwards all writes to the single master server.
All reads are forwarded to all members of the cluster, both master and slave servers.
 
The proxy layer is fronted by a Rancher load balancer. 
Clients should access the cluster through the load balancer. 

### Usage:

Once deployed, use a mysql client to connect:

`mysql -u<db_user> -p -h<mariadb-lb>`
