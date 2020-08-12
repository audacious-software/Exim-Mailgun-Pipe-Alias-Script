# Exim-Mailgun-Pipe-Alias-Script
Bash script for sending e-mail using a pipe alias with Exim.

If you want to use Mailgun's HTTP API instead of its SMTP interface, add the following alias to `/etc/aliases`:

    aliasname:     "|/path/to/send_mailgun.sh destination@example.com api:your-mailgun-api-key your.mailgun.domain"

Update the arguments above to point to the destination address for e-mails processed by the script, your Mailgun API key, and Mailgun domain.

## Additional Exim Setup

On Debian systems, Exim4 in its default configuration does not allow piping of an incoming mail into  a program defined in /etc/aliases. Instead of launching the program it will report this type of error in /var/log/exim4/mainlog:

    system_aliases defer (-30): pipe_transport unset in system_aliases router
    Yet that’s the method  suggested in manitou-mdx documentation’s “Delivering incoming mail into files”  section, and it has the advantage of being quite standard     across most  MTAs.  This is also a problem for  popular mail software such as MailMan, as mentioned in this Ubuntu issue.

The solution is similar to the one mentioned in the above issue, except that it’s better to create a custom configuration file rather than editing `exim4.conf.template`, according to update-exim4.conf manpage.

In the simplest case where a split configuration for Exim is not used (`dc_use_split_config=’false’`), the fix is as simple as creating `/etc/exim4/exim4.conf.localmacros` containing:

    SYSTEM_ALIASES_PIPE_TRANSPORT = address_pipe
    SYSTEM_ALIASES_USER and SYSTEM_ALIASES_GROUP may be specified too if the defaults are not suitable, but only SYSTEM_ALIASES_PIPE_TRANSPORT is strictly necessary.

If a split configuration is used, the line should go into a file under `/etc/exim4/conf.d`, e.g. `/etc/exim4/conf.d/main/000_localmacros`.

(Via https://www.manitou-mail.org/blog/2012/09/exim4-and-its-pipe_transport-unset-error/)

---


Feel free to edit the script to replace the default *from address* and *subject* used when those values cannot be parsed out of the e-mail provided.
