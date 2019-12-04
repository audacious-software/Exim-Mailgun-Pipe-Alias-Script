# Exim-Mailgun-Pipe-Alias-Script
Bash script for sending e-mail using a pipe alias with Exim.

If you want to use Mailgun's HTTP API instead of its SMTP interface, add the following alias to `/etc/aliases`:

    aliasname:     "|/path/to/send_mailgun.sh destination@example.com api:your-mailgun-api-key your.mailgun.domain"

Update the arguments above to point to the destination address for e-mails processed by the script, your Mailgun API key, and Mailgun domain.

Feel free to edit the script to replace the default *from address* and *subject* used when those values cannot be parsed out of the e-mail provided,
