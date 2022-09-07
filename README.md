# tech_challenge

## 1- Create a SQL Database  <br />
The file with name 1.txt includes the SQL statements. I created 7 tables, 1 function and 1 trigger. <br />
We can track or audit for the changes of albums table by the trigger. <br />
I added PostgreSQL database dump file with name pex.sql <br />
<br />
<br />
<br />
## 2- Scripting / Automating <br />
<br />
I prefer to use Ansible. The file 2.txt includes the Ansible code. <br />
First of all, we should add IP address to ansible host file ( /etc/ansible/hosts ) <br />
vi /etc/ansible/hosts and add below lines into this file<br /> (OR, We can add all the IP addresses one under the other.)
[postgres_hosts]<br />
10.0.3.[20:25] <br />
And, we should create playbook file ( vi postgres_upgrade.ply , then copy 2.txt file into this file ) <br />
I designed a basic major upgrade operation, if needed it can be added all extensions which are used by the database. <br />
For the BONUS question: We can add this block : <br />
<br />
  - name: Kill long running queries for web user<br />
	  postgresql_query:<br />
    db: pex<br />
    query: SELECT pg_terminate_backend(pid) from pg_stat_activity where usename = 'web' and now() > query_start  + (interval '1 minute')<br />
    <br />
    <br />

## 3-Create a NoSQL Database (MongoDB)<br />

I created a mongoDB database ( use pex ) <br />
After creation the pex database, I created a collection, pex. ( db.createCollection('artists')<br />
Finally, I inserted some documents into this collection. I added pex database dump file. (mongodumpfile folder) <br />
<br />
### Bonus Question<br />
Mmongodb does not support triggers. Instead, we can audit the changes made for a particular collection.<br />
{<br />
    atype: "authCheck",<br />
    "param.ns": "pex.artists",<br />
    "param.command": { $in: [ "insert", "delete", "update", "findandmodify" ] }<br />
}<br />
<br />
Q: Sort said documents in ascending order (I used the id field for sort key , because the sort key is not spesified in the question.)<br />
A: db.artists.find().sort({"id":1}).pretty()<br />
<br />
Q: Filter the documents using a covered query based on Rightsholders.<br />
A:  db.artists.find({"firt_name":"Jack","last_name":"Pink"}).pretty() <br />
<br />
Q: Calculate the Global Quantity.<br />
A: I did not understand the question.<br />
<br />
Q: Configure the cache size for MMAPv1 <br />
A: With MMAPv1, MongoDB automatically uses all free memory on the machine as its cache. <br />



