# tech_challenge

## 1- Create a SQL Database  <br />
The file with name 1.txt includes the SQL statements. I created 7 tables, 1 function and 1 trigger. <br />
### Bonus Question<br />
We can track or audit for the changes of albums table by the trigger. <br />
<br />
create trigger trg_albums before<br />
update<br />
    of artist_id on<br />
    pex.albums for each row execute function pex.audit_for_albums();<br />
<br />
CREATE OR REPLACE FUNCTION pex.audit_for_albums()<br />
 RETURNS trigger<br />
 LANGUAGE plpgsql<br />
AS $function$<br />
BEGIN<br />
INSERT INTO audit_albums (title,old_artist_id,artist_id,username,entry_date) VALUES (NEW.title,OLD.artist_id,NEW.artist_id,current_user,current_date);<br />
RETURN NEW;<br />
<br />
END;<br />
<br />
$function$<br />
;<br />
<br />
Finally, I added PostgreSQL database dump file with name pex_pgdump.sql <br />
<br />
<br />
## 2- Scripting / Automating <br />
<br />
I prefer to use Ansible. The file 2.txt includes the Ansible code. <br />
First of all, we should add IP address to ansible host file ( /etc/ansible/hosts ) <br />
vi /etc/ansible/hosts and add below lines into this file<br /> (OR, We can add all the IP addresses one under the other.)<br />
[postgres_hosts]<br />
192.168.[100:120] <br />
And, we should create playbook file ( vi postgres_upgrade.ply , then copy 2.txt file into this file ) <br />
I designed a basic major upgrade operation, if needed it can be added all extensions which are used by the database. <br />
### Bonus Question<br /> 
We can add this block : <br />
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
<br />
## 4- Q & A<br />
<br />
A1: This depends entirely on the application structure.If the application needs a relationship between objects, RDBMS may be the better option. Or, for example, MongoDB is a better option if the application is schema independent.<br />
I can't decide which database is better just by looking at a few tables. However, being independent of the schema desing can be practical.So, MongoDB for example, may be better option than the others.<br />
<br />
A2: Triggers can execute every time some field in database is updated. If a field is likely to be updated often, it is a system overhead.Also, triggers can have a hidden behaviour.
But,triggers may be useful in some cases ( allows easy auditing of data,helps us to automate the data alterations etc) ,however we should not use triggers as much as possible. There should be as few logical operations as possible in the database., such as triggers, functions, procedures etc.<br />
<br />
A3: I don't know much about FoundationDB, but I found an information on the internet about this problem:<br />
Fdb keeps a list of the transaction started within 5 sec. Also, data nodes only keep versions of the last 5sec. So if the read version is smaller than the last version kept by dataNodes, the dataNodes have no way to answer the request. That's why fdb throws this exception. the trick to evade from such exceptions is to split one huge time taking transaction to many small transactions. I also noticed fdb performs really well if the transaction time < 300ms.<br />
<br />
A4: IF : data persistence is not the highest priority , need fast and frequent access to data, loss of data (or at least the possibility of this) is workable for the application, we can run a database completely in-memory with no permanent data storage.<br />
<br />
A5: I think, ZFS is a sophisticated file system, and it has very useful properties.But, it is expensive option. My favorite FS is XFS :)


