hosts=127.0.0.1
user=mxhero
password=mxhero
dbname=mxhero
query=SELECT 1 FROM email_accounts INNER JOIN domains_aliases ON email_accounts.domain_id = domains_aliases.domain WHERE account = '%u' AND domains_aliases.alias = '%d';
